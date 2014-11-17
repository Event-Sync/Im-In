//
//  ViewActivityViewController.h
//  I'm In
//
//  Created by Matthew Brightbill on 11/17/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewActivityViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstAttendeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondAttendeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdAttendeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourthAttendeeLabel;

@end
