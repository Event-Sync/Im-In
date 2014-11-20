//
//  LoginViewController.m
//  I'm In
//
//  Created by Matthew Brightbill on 11/17/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "LoginViewController.h"
#import "ActivityTabViewController.h"
#import "NetworkController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Login";
    [[self.loginButton layer] setBorderWidth:2.0f];
    [[self.loginButton layer] setCornerRadius:10];
    [[self.loginButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    self.loginButton.titleEdgeInsets = UIEdgeInsetsMake(7, 0, 0, 0);
    self.loginButton.titleLabel.font = [UIFont fontWithName:@"Shree Devanagari 714" size:37];
}

- (IBAction)loginPressed:(id)sender {
    
    NSLog(@"Login Pressed!");
    
    NSDictionary *loginDictionary = @{
         @"phone_number" : self.phoneNumberTextField.text,
         @"password" : self.passwordTextField.text
    };
    
    [[NetworkController sharedInstance] loginWithCompletion:loginDictionary completionHandler:^(NSError *error, BOOL response) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            if (response == YES) {
                ActivityTabViewController *activityTabVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ACTIVITYTAB_VC"];
                [self presentViewController:activityTabVC animated:true completion:nil];
            }
        }
    }];
    
}



@end
