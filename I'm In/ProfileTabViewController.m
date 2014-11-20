//
//  ProfileTabViewController.m
//  I'm In
//
//  Created by Matthew Brightbill on 11/17/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "ProfileTabViewController.h"
#import "MenuViewController.h"

@interface ProfileTabViewController ()

@end

@implementation ProfileTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Profile";
    [[self.logoutButton layer] setBorderWidth:2.0f];
    [[self.logoutButton layer] setCornerRadius:10];
    [[self.logoutButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    self.logoutButton.titleEdgeInsets = UIEdgeInsetsMake(7, 0, 0, 0);
    self.logoutButton.titleLabel.font = [UIFont fontWithName:@"Shree Devanagari 714" size:37];
    
}

- (IBAction)logoutButtonPressed:(id)sender {
    NSLog(@"Logout Pressed");
    MenuViewController *menuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MENU_VC"];
    [self presentViewController:menuVC animated:true completion:nil];
}


@end
