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
}

- (IBAction)loginPressed:(id)sender {
    
    NSLog(@"Login Pressed!");
    
    NSDictionary *loginDict = @{
         @"phone_number" : self.phoneNumberTextField.text,
         @"password" : self.passwordTextField.text
    };
    
    [[NetworkController sharedInstance] createAccountOrLoginWithCompletion:loginDict completionHandler:^(NSError *error, BOOL response) {
        
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
