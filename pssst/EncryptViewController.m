//
//  EncryptViewController.m
//  pssst
//
//  Created by Aaron Augsburger on 1/18/14.
//
//

#import "EncryptViewController.h"

@implementation EncryptViewController

@synthesize friendArray, pickerView;

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [friendArray count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [friendArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    friendArray = [[NSMutableArray alloc] init];
    
    [friendArray addObject:@"Brad"];
    [friendArray addObject:@"Carl"];
    [friendArray addObject:@"Jill"];
    [friendArray addObject:@"Margret"];
    [friendArray addObject:@"Sarah"];
}

- (IBAction)downSwipe:(id)sender
{
    [self.view endEditing:YES];
    
    self.plainText.text = [RSA encryptDatIsh:self.plainText.text];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [NSString stringWithFormat:@"Pssst://%@", self.plainText.text];
    self.plainText.text = @"ENCRYPTED";

    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText]) {
        controller.body = pasteboard.string;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)removeFriend:(id)sender {
    [friendArray removeObject:friendArray[[pickerView selectedRowInComponent:0]]];
    [pickerView reloadAllComponents];
}

- (IBAction)addFriend:(id)sender {
    MFMessageComposeViewController *addFriendController = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText]) {
        NSString *friendRequest = @"Pssst://|";
        friendRequest = [friendRequest stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"PublicKey"]];
        friendRequest = [NSString stringWithFormat:@"|%@",[friendRequest stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"Name"]]];
        addFriendController.body = [NSString stringWithFormat: @"Hey!  Be my friend on pssst and we can send secret messages back and forth! Just click the link below if you want to be friends.\n%@",friendRequest];
        addFriendController.messageComposeDelegate = self;
        [self presentViewController:addFriendController animated:YES completion:NULL];
    }

}
@end