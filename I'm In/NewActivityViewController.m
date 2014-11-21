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
//@property (weak, nonatomic)
@end

@implementation NewActivityViewController

- (IBAction)dateButtonPressed:(UIButton *)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"New Event";
    
    ActivityProtocol *activityProtocol = [[ActivityProtocol alloc] init];
    activityProtocol.delegate = self;
    
    [[self.createButton layer] setBorderWidth:2.0f];
    [[self.createButton layer] setCornerRadius:10];
    [[self.createButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    self.createButton.titleEdgeInsets = UIEdgeInsetsMake(7, 0, 0, 0);
    self.createButton.titleLabel.font = [UIFont fontWithName:@"Shree Devanagari 714" size:37];
    
    self.enterEventNameTextField.delegate = self;
    self.enterLocationTextField.delegate = self;
    self.enterPhoneNumberTextField.delegate = self;
    self.enterTimeTextField.delegate = self;
    self.describeEventTextField.delegate = self;
    
    
}

- (void)processCompleted{
    NSLog(@"processCompleted");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.enterEventNameTextField resignFirstResponder];
    [self.enterLocationTextField resignFirstResponder];
    [self.enterPhoneNumberTextField resignFirstResponder];
    [self.enterTimeTextField resignFirstResponder];
    [self.describeEventTextField resignFirstResponder];
    
    return YES;
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
                         @"name": _activityNameTextField.text,
                         @"phone_number": _telephoneNoTextField.text,
                         @"confirmed": @false
                     },
                     @{
                         @"name": @"Matt",
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
