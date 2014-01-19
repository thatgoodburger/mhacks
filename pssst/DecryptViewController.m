//
//  DecryptViewController.m
//  pssst
//
//  Created by Aaron Augsburger on 1/18/14.
//
//

#import "DecryptViewController.h"

@implementation DecryptViewController

@synthesize cipherText;

- (IBAction)clearTextButton:(id)sender
{
	cipherText.text = @"your text is now decrypted";
}

- (void)passData: (NSString *) data {
    //self.cipherText.text = data;
    self.cipherText.text = [RSA decryptDatIsh:data];
    
}
@end