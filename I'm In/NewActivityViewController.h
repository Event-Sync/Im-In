//
//  NewActivityViewController.h
//  I'm In
//
//  Created by Matthew Brightbill on 11/17/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityProtocol.h"

@class NewActivityViewController;
@protocol ActivityDelegate
- (void) reloadActivity:(NewActivityViewController *) newActivityViewController;
@end

@interface NewActivityViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UITextField *enterEventNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *describeEventTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterLocationTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterPhoneNumberTextField;


@end
