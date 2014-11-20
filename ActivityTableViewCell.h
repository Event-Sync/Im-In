//
//  ActivityTableViewCell.h
//  I'm In
//
//  Created by Sam Wong on 17/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

@interface ActivityTableViewCell : UITableViewCell
@property (nonatomic, strong) Activity *activity;
@property (strong, nonatomic) NSString *eventId;
@end
