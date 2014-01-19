//
//  DecryptViewController.h
//  pssst
//
//  Created by Aaron Augsburger on 1/18/14.
//
//

#import <UIKit/UIKit.h>
#import "RSA.h"


@interface DecryptViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *cipherText;

- (IBAction)clearTextButton:(id)sender;
- (void) passData: (NSString *) data;
@end