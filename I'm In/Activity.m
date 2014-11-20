//
//  Activity.m
//  I'm In
//
//  Created by Sam Wong on 17/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "Activity.h"
#import "Attendee.h"

@interface Activity()

@end

@implementation Activity

- (instancetype) initWithDictionary: (NSDictionary *) activityDictionary {
    if (self = [super init]) {
        
        _eventId = activityDictionary[@"event_id"];
        _eventName = activityDictionary[@"event_name"];
        //_eventDescription = activityDictionary[@"event_description"];

        _eventLocation = activityDictionary[@"event_location"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSDate *date  = [dateFormatter dateFromString: activityDictionary[@"event_time"]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *newDate = [dateFormatter stringFromDate:date];
//        NSLog(@"date %@", date);
//        NSLog(@"newDate %@", newDate);
        
        _eventTime  = newDate;
        
        if ([self isEndDateIsSmallerThanCurrent:(date)] == YES ) {
            _eventExpired = 1;
        } else {
            _eventExpired = 0;
        }
//        _eventExpired  =  [(NSNumber *) activityDictionary[@"event_expired"] boolValue];
        _statusCode = (NSInteger) activityDictionary[@"status_code"];
    }

    return self;
}

- (BOOL)isEndDateIsSmallerThanCurrent:(NSDate *)checkEndDate
{
    NSDate* enddate = checkEndDate;
    NSDate* currentdate = [NSDate date];
    NSTimeInterval distanceBetweenDates = [enddate timeIntervalSinceDate:currentdate];
    double secondsInMinute = 60;
    NSInteger secondsBetweenDates = distanceBetweenDates / secondsInMinute;
    
    if (secondsBetweenDates == 0)
        return YES;
    else if (secondsBetweenDates < 0)
        return YES;
    else
        return NO;
}

+ (NSMutableArray *)parseJSONDataIntoActivities: (NSData *)rawJSONData {
    NSError *error = nil;
    NSMutableArray *activities = [[NSMutableArray alloc]init];
    NSDictionary *searchJSONDictionary = [NSJSONSerialization JSONObjectWithData:rawJSONData options:0 error:&error];
    
    for (NSDictionary *itemsDictionary in searchJSONDictionary) {
        Activity *activityObject = [[Activity alloc] initWithDictionary: itemsDictionary];
        [activities addObject: activityObject];
    }
    
    return activities;
}

+ (Activity *)parseJSONDataIntoActivity: (NSData *)rawJSONData {
    NSError *error = nil;

    NSDictionary *activityJSONDictionary = [NSJSONSerialization JSONObjectWithData:rawJSONData options:0 error:&error];
    
    Activity *activity = [[Activity alloc] initWithDictionary: activityJSONDictionary];
    
    NSMutableArray *attendees = [[NSMutableArray alloc]init];
    
    for (NSDictionary *inviteeDictionary in activityJSONDictionary[@"invitees"]) {
        Attendee *newAttendee = [[Attendee alloc] initWithDictionary: inviteeDictionary];
        [attendees addObject: newAttendee];
    }
    [activity setAttendees: attendees];
    
    return activity;
}

@end
