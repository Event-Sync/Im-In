//
//  Activity.h
//  I'm In
//
//  Created by Sam Wong on 17/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject

@property (nonatomic) NSInteger eventId;
@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSString *eventLocation;
@property (nonatomic, strong) NSString *eventTime;
@property (nonatomic) BOOL eventExpired;
@property (nonatomic) NSInteger statusCode;
@property (nonatomic, strong) NSMutableArray *invitess;

- (instancetype) initWithDictionary: (NSDictionary *) activityDictionary;
+ (NSMutableArray *) parseJSONDataIntoActivities: (NSData *)rawJSONData;

@end
