//
//  NewActivityViewController.m
//  I'm In
//
//  Created by Matthew Brightbill on 11/17/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "NewActivityViewController.h"
#import "NetworkController.h"
#import "ActivityTabViewController.h"

@interface NewActivityViewController ()

@end

@implementation NewActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"New Event";
}

- (IBAction)createButtonPressed:(id)sender {
    NSLog(@"Create Button Pressed!");
    
    NSDictionary *newEventDict = @{
        @"event_name": @"Interstellar movie meetup",
        @"event_description": @"movie meetup description",
        @"event_location": @"Code Fellows Cinema",
        @"event_time": @"MM/NN/YYYY HH:MMAM",
        @"invitees": @[
                     @{
                         @"name": @"Sam",
                         @"phone_number": @"2064669834",
                         @"confirmed": @false
                     },
                     @{
                         @"name": @"Sam",
                         @"phone_number": @"2064669834",
                         @"confirmed": @false
                     }
                     ],
        @"event_expired": @false
        };
    
    [[NetworkController sharedInstance] createNewEventWithCompletion:newEventDict completionHandler:^(NSError *error, BOOL response) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            if (response == YES) {
                ActivityTabViewController *activityTabVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ACTIVITYTAB_VC"];
                [self presentViewController:activityTabVC animated:true completion:nil];
    
                NSLog(@"Passed the network call for new event.");
            }
        }
    }];
}

@end
