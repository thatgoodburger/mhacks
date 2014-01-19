//
//  RSA.m
//  pssst
//
//  Created by Bradley Menchl on 1/18/14.
//
//

#import "RSA.h"

@implementation RSA

+(void)generateKeyPairWithPublicTag:(NSString *)publicTagString privateTag:(NSString *)privateTagString {
	NSMutableDictionary *privateKeyAttr = [[NSMutableDictionary alloc] init];
	NSMutableDictionary *publicKeyAttr = [[NSMutableDictionary alloc] init];
	NSMutableDictionary *keyPairAttr = [[NSMutableDictionary alloc] init];
	
	NSData *publicTag = [publicTagString dataUsingEncoding:NSUTF8StringEncoding];
	NSData *privateTag = [privateTagString dataUsingEncoding:NSUTF8StringEncoding];
	
	SecKeyRef publicKey = NULL;
	SecKeyRef privateKey = NULL;
	
	[keyPairAttr setObject:(__bridge id)kSecAttrKeyTypeRSA
                    forKey:(__bridge id)kSecAttrKeyType];
	[keyPairAttr setObject:[NSNumber numberWithInt:2048]
                    forKey:(__bridge id)kSecAttrKeySizeInBits];
	
	[privateKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecAttrIsPermanent];
	[privateKeyAttr setObject:privateTag forKey:(__bridge id)kSecAttrApplicationTag];
	
	[publicKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecAttrIsPermanent];
	[publicKeyAttr setObject:publicTag forKey:(__bridge id)kSecAttrApplicationTag];
	
	[keyPairAttr setObject:privateKeyAttr forKey:(__bridge id)kSecPrivateKeyAttrs];
	[keyPairAttr setObject:publicKeyAttr forKey:(__bridge id)kSecPublicKeyAttrs];
	
	//OSStatus err = SecKeyGeneratePair((__bridge CFDictionaryRef)keyPairAttr, &publicKey, &privateKey);
	
	if(publicKey) CFRelease(publicKey);
	if(privateKey) CFRelease(privateKey);
}

+(NSString *)decryptRSA:(NSString *)cipherString key:(SecKeyRef) privateKey {
	size_t plainBufferSize = SecKeyGetBlockSize(privateKey);
	uint8_t *plainBuffer = malloc(plainBufferSize); NSData *incomingData = [NSData dataFromBase64String:cipherString];
	uint8_t *cipherBuffer = (uint8_t*)[incomingData bytes];
	size_t cipherBufferSize = SecKeyGetBlockSize(privateKey);
	SecKeyDecrypt(privateKey,
                  kSecPaddingOAEP,
                  cipherBuffer,
                  cipherBufferSize,
                  plainBuffer,
                  &plainBufferSize);
	NSData *decryptedData = [NSData dataWithBytes:plainBuffer length:plainBufferSize];
	NSString *decryptedString = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding]; return decryptedString;
}

+(NSString *)encryptRSA:(NSString *)plainTextString key:(SecKeyRef)publicKey {
	size_t cipherBufferSize = SecKeyGetBlockSize(publicKey);
	uint8_t *cipherBuffer = malloc(cipherBufferSize);
	uint8_t *nonce = (uint8_t *)[plainTextString UTF8String];
	SecKeyEncrypt(publicKey,
                  kSecPaddingOAEP,
                  nonce,
                  strlen( (char*)nonce ),
                  &cipherBuffer[0],
                  &cipherBufferSize);
	NSData *encryptedData = [NSData dataWithBytes:cipherBuffer length:cipherBufferSize];
	return [encryptedData base64EncodedString];
}

+(NSString *)encryptDatIsh:(NSString *)plainTextString {
    plainTextString = [plainTextString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    char *cString = (char *)[[plainTextString lowercaseString] UTF8String];
    for(int i =0; i < plainTextString.length; i++) {
        cString[i]++;
        if(cString[i] == 123) {
            cString[i] = 97;
        }
    }
    return [NSString stringWithUTF8String:cString];
}
+(NSString *)decryptDatIsh:(NSString *)cipherTextString {
    char *cString = (char *)[[cipherTextString lowercaseString] UTF8String];
    for(int i =0; i < strlen(cString); i++) {
        cString[i]--;
        if(cString[i] == 96) {
            cString[i] = 122;
        }
    }
    return [[NSString stringWithUTF8String:cString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end
