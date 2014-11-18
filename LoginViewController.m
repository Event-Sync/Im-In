//
//  LoginViewController.m
//  I'm In
//
//  Created by Matthew Brightbill on 11/17/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "LoginViewController.h"
#import "ActivityTabViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)loginPressed:(id)sender {
    
    ActivityTabViewController *activityTabVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ACTIVITYTAB_VC"];
    [self presentViewController:activityTabVC animated:true completion:nil];
    
}



@end
