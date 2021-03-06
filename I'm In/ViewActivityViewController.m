//
//  ViewActivityViewController.m
//  I'm In
//
//  Created by Matthew Brightbill on 11/17/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "ViewActivityViewController.h"
#import "NetworkController.h"
#import "Activity.h"
#import "Attendee.h"
#import "AttendeeTableViewCell.h"

@interface ViewActivityViewController ()  <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) NSMutableArray *attendees;

@end

@implementation ViewActivityViewController

//- (IBAction)updateButtonPressed:(UIButton *)sender {
//    NSLog(@"Update Button Pressed!");
//    
//    NSString *authToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"authToken"];
//    
//    NSDictionary *eventDictionary = @{
//                                   @"jwt": authToken,
//                                   @"event_name": _eventNameLabel.text,
//                                   @"event_description": @"description",
//                                   @"event_location": _locationLabel.text,
//                                   @"event_time": @"2014-12-20T19:19:41.174Z",
//                                   @"invitees": @[
//                                           @{
//                                               @"name": @"Jacob",
//                                               @"phone_number": @"+19152521559",
//                                               @"confirmed": @false
//                                                   }
//                                           ],
//                                   @"event_expired": @false
//                                       };
//
//    [[NetworkController sharedInstance] updateEventWithCompletion: eventDictionary completionHandler:^(NSError *error, BOOL response) {
//        if (error != nil) {
//            NSLog(@"%@", error.localizedDescription);
//        } else {
//            if (response == YES) {
////                ActivityTabViewController *activityTabVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ACTIVITYTAB_VC"];
////                [self presentViewController:activityTabVC animated:true completion:nil];
////                
////                NSLog(@"Passed the network call for new event.");
//            }
//        }
//    }];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AttendeeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CELL"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    
    if (_activity != nil) {
        [[NetworkController sharedInstance] fetchEventWithCompletion:_activity.eventId completionHandler: ^(NSError *error, Activity *response) {
            if (error != nil) {
                
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"Error"
                                      message:@"There is an error from server"
                                      delegate:nil
                                      cancelButtonTitle:@"Dismiss"
                                      otherButtonTitles:nil];
                
                [alert show];
                
                NSLog(@"%@", error.localizedDescription);
            } else {
                if (response != nil) {
                    _activity = response;
                    
                    _eventNameLabel.text = _activity.eventName;
                    _timeLabel.text = _activity.eventTime;
                    _locationLabel.text = _activity.eventLocation;
                    if (_activity.eventExpired) {
                        _eventStatusLabel.text = @"Expired";
                    } else {
                        _eventStatusLabel.text = @"Active";
                    }
                    
                    _attendees = _activity.attendees;
                    [_tableView reloadData];
                }
            }
        }];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AttendeeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    Attendee *newAttendee = _attendees[indexPath.row];
    cell.nameLabel.text = newAttendee.name;
    cell.telephoneNoLabel.text = newAttendee.telephoneNo;
    
    if (newAttendee.confirmationStatus == YES ) {
        cell.statusLabel.text = @"Confirmed";
    } else {
        cell.statusLabel.text = @"Not confirmed";
    }
    //cell.imageView.image = [UIImage imageNamed:@"defaultImage.jpeg"];
    
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _attendees.count;

}



@end
