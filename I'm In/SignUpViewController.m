//
//  SignUpViewController.m
//  I'm In
//
//  Created by Matthew Brightbill on 11/17/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "SignUpViewController.h"
#import "ActivityTabViewController.h"
#import "NetworkController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Sign Up";
    [[self.registerButton layer] setBorderWidth:2.0f];
    [[self.registerButton layer] setCornerRadius:10];
    [[self.registerButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    self.registerButton.titleEdgeInsets = UIEdgeInsetsMake(7, 0, 0, 0);
    self.registerButton.titleLabel.font = [UIFont fontWithName:@"Shree Devanagari 714" size:37];
}

- (IBAction)registerPressed:(id)sender {
    
    NSLog(@"Register pressed!");
    
    NSDictionary *newAccountDict = @{
         @"name" : self.nameTextField.text,
         @"phone_number" : self.phoneNumberTextField.text,
         @"password" : self.passwordTextField.text
    };
    
    
    [[NetworkController sharedInstance] createAccountWithCompletion:newAccountDict completionHandler:^(NSError *error, BOOL response) {
        
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