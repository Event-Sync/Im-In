//
//  MenuViewController.m
//  I'm In
//
//  Created by Matthew Brightbill on 11/17/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "MenuViewController.h"
#import "SignUpViewController.h"
#import "LoginViewController.h"

@interface MenuViewController ()



@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[self.signUpButton layer] setBorderWidth:2.0f];
    [[self.signUpButton layer] setBorderColor:[UIColor whiteColor].CGColor];
}

- (IBAction)signUpPressed:(id)sender {
    SignUpViewController *signUpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SIGNUP_VC"];
    [self.navigationController pushViewController:signUpVC animated:true];
}


- (IBAction)loginPressed:(id)sender {
    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LOGIN_VC"];
    [self.navigationController pushViewController:loginVC animated:true];
}


@end
