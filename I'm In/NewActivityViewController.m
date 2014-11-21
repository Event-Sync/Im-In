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

@property (weak, nonatomic) IBOutlet UITextField *telephoneNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *activityNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *eventDescriptionTextField;

@property (strong, nonatomic) NSMutableArray *attendees;

@end

@implementation NewActivityViewController

- (IBAction)dateButtonPressed:(UIButton *)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"New Event";
    
    ActivityProtocol *activityProtocol = [[ActivityProtocol alloc] init];
    activityProtocol.delegate = self;
    
}

- (void)processCompleted{
    NSLog(@"processCompleted");
}

- (IBAction)createButtonPressed:(id)sender {
    NSLog(@"Create Button Pressed!");
    
    NSString *authToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"authToken"];
    
    NSDictionary *newEventDict = @{
        @"jwt": authToken,
        @"event_name": _activityNameTextField.text,
        @"event_description": _eventDescriptionTextField.text,
        @"event_location": @"new location", //_locationTextField.text,
        @"event_time": @"2014-12-20T19:19:41.174Z", // _timeTextField.text,
        @"invitees": @[
                     @{
                         @"name": @"Sam",
                         @"phone_number": @"+12064669834",
                         @"confirmed": @false
                     },
                     @{
                         @"name": @"Jacob",
                         @"phone_number": @"+19152521559",
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
