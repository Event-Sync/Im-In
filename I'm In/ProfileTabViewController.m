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
}

- (IBAction)logoutButtonPressed:(id)sender {
    NSLog(@"Logout Pressed");
    MenuViewController *menuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MENU_VC"];
    [self presentViewController:menuVC animated:true completion:nil];
}


@end
