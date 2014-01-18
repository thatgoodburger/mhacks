//
//  DecryptViewController.h
//  pssst
//
//  Created by Aaron Augsburger on 1/18/14.
//
//

#import <UIKit/UIKit.h>

@interface DecryptViewController : UIViewController
- (BOOL) passData: (NSString *) data;

- (IBAction)decryptText:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *decryptTextView;

@end
