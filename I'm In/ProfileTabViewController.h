//
//  ProfileTabViewController.h
//  I'm In
//
//  Created by Matthew Brightbill on 11/17/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTabViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameEntryLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end
