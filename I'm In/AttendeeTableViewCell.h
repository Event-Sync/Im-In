//
//  AttendeeTableViewCell.h
//  I'm In
//
//  Created by Sam Wong on 19/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendeeTableViewCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end
