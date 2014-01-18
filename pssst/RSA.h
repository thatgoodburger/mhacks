//
//  RSA.h
//  pssst
//
//  Created by Bradley Menchl on 1/18/14.
//
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import "NSData+Base64.h"

@interface RSA : NSObject


+(void)generateKeyPairWithPublicTag:(NSString *)publicTagString privateTag:(NSString *)privateTagString;

+(NSString *)decryptRSA:(NSString *)cipherString key:(SecKeyRef) privateKey;

+(NSString *)encryptRSA:(NSString *)plainTextString key:(SecKeyRef)publicKey;

@end
