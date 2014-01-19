//
//  EncryptViewController.h
//  pssst
//
//  Created by Aaron Augsburger on 1/18/14.
//
//

#import <UIKit/UIKit.h>
#import "RSA.h"
#import <MessageUI/MessageUI.h>

@interface EncryptViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, MFMessageComposeViewControllerDelegate>

- (IBAction)downSwipe:(id)sender;
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result;

@property (weak, nonatomic) IBOutlet UITextView *encryptTextView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextView *plainText;
@property (weak, nonatomic) IBOutlet UIButton *addFriend;
@property (weak, nonatomic) IBOutlet UIButton *deleteFriend;

@property (strong, nonatomic) NSMutableArray *friendArray;

@end
