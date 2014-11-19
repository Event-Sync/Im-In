//
//  SignUpViewController.m
//  I'm In
//
//  Created by Matthew Brightbill on 11/17/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "SignUpViewController.h"
#import "ActivityTabViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)registerPressed:(id)sender {
    
    NSLog(@"Register pressed!");
    
     ActivityTabViewController *activityTabVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ACTIVITYTAB_VC"];
    [self presentViewController:activityTabVC animated:true completion:nil];
}




@end
