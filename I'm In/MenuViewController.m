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
#import "AYVibrantButton.h"

@interface MenuViewController ()



@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[self.signUpButton layer] setBorderWidth:2.0f];
    [[self.signUpButton layer] setCornerRadius:10];
    [[self.signUpButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    self.signUpButton.titleEdgeInsets = UIEdgeInsetsMake(7, 0, 0, 0);
    
    [[self.loginButton layer] setBorderWidth:2.0f];
    [[self.loginButton layer] setCornerRadius:10];
    [[self.loginButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    self.loginButton.titleEdgeInsets = UIEdgeInsetsMake(7, 0, 0, 0);
    
    self.signUpButton.titleLabel.font = [UIFont fontWithName:@"Shree Devanagari 714" size:37];
    self.loginButton.titleLabel.font = [UIFont fontWithName:@"Shree Devanagari 714" size:37];
    
//    UIImage* logoImage = [UIImage imageNamed:@"transparent logo 2.tiff"];
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
    

    
}

- (IBAction)signUpPressed:(id)sender {
    
    NSLog(@"Sign up on main menu pressed!");
    SignUpViewController *signUpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SIGNUP_VC"];
    //[self presentViewController:signUpVC animated:true completion:nil];
    [self.navigationController pushViewController:signUpVC animated:true];
}


- (IBAction)loginPressed:(id)sender {
    
    NSLog(@"Login on main menu pressed!");
    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LOGIN_VC"];
    [self.navigationController pushViewController:loginVC animated:true];
}


@end
