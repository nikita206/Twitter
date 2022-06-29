//
//  ComposeViewController.m
//  twitter
//
//  Created by Nikita Agarwal on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () 
@property (weak, nonatomic) IBOutlet UILabel *characterCount;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ComposeViewController
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetButton:(id)sender {
    [[APIManager shared] postStatusWithText:(self.textView.text) completion:^(Tweet * tweet, NSError * error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderWidth = 0.5;
    self.textView.delegate = self;
    [self.textView becomeFirstResponder];
}


-(void)textViewDidChange:(UITextView *)textView{
    NSString *substring = [NSString stringWithString:textView.text];
    if(substring.length > 0){
        self.characterCount.hidden = NO;
        self.characterCount.text = [NSString stringWithFormat:@"%d characters", substring.length];
    }
    
    if(substring.length == 0){
        self.characterCount.hidden = YES;
    }
    
    if(substring.length == 10){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Limit exceeded" message:@"Character limit is 10. Please reduce characters"
        preferredStyle:UIAlertControllerStyleAlert];
         
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
           handler:^(UIAlertAction * action) {}];
         
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if(substring.length > 10){
        self.characterCount.textColor = [UIColor redColor];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
