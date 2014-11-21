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

@interface LoginViewController () <UIAlertViewDelegate>

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
    
    self.phoneNumberTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (IBAction)loginPressed:(id)sender {
    
    NSLog(@"Login Pressed!");
    
    NSDictionary *loginDictionary = @{
         @"phone_number" : self.phoneNumberTextField.text,
         @"password" : self.passwordTextField.text
    };
    
    [[NetworkController sharedInstance] loginWithCompletion:loginDictionary completionHandler:^(NSError *error, BOOL response) {
        if (error != nil) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Login Error!"
                                  message:@"Unable to log in, try again later"
                                  delegate:nil
                                  cancelButtonTitle:@"OK!"
                                  otherButtonTitles:nil];
            [alert show];
            
            NSLog(@"%@", error.localizedDescription);
        } else {
            if (response == YES) {
                
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"Welcome!"
                                      message:@"You're now logged in"
                                      delegate:self
                                      cancelButtonTitle:@"OK!"
                                      otherButtonTitles:nil];
                [alert show];
                

            }
        }
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.phoneNumberTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    return YES;
}


@end
