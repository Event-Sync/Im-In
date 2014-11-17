//
//  NewActivityViewController.h
//  I'm In
//
//  Created by Matthew Brightbill on 11/17/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewActivityViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *activityNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstInviteePhoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *firstInviteeAddButton;
@property (weak, nonatomic) IBOutlet UITextField *secondInviteePhoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *secondInviteeButton;
@property (weak, nonatomic) IBOutlet UITextField *thirdInviteePhoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *thirdInviteeButton;
@property (weak, nonatomic) IBOutlet UITextField *fourthInviteePhoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *fourthInviteeButton;

@end
