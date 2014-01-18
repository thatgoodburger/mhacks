//
//  DecryptViewController.m
//  pssst
//
//  Created by Aaron Augsburger on 1/18/14.
//
//

#import "DecryptViewController.h"

@implementation DecryptViewController
- (void)passData: (NSString *) data {
    self.cipherText.text = data;
}

@end
