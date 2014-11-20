//
//  Attendee.h
//  I'm In
//
//  Created by Sam Wong on 19/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Attendee : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *telephoneNo;
@property (nonatomic) BOOL confirmationStatus;
@property (nonatomic, strong) UIImage *profileImage;
- (instancetype) initWithDictionary: (NSDictionary *) attendeeDictionary;
@end
