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
        _eventDescription = activityDictionary[@"event_description"];
        _eventLocation = activityDictionary[@"event_location"];
        _eventTime  = activityDictionary[@"event_time"];
        _eventExpired  =  [(NSNumber *) activityDictionary[@"event_expired"] boolValue];
        _statusCode = (NSInteger) activityDictionary[@"status_code"];
    }
    return self;
}

//- (instancetype) initWithDictionaries: (NSDictionary *) activityDictionary inviteeDictionary: (NSDictionary *) inviteeDictionary {
//    if (self = [super init]) {
//        _eventId = activityDictionary[@"event_id"];
//        _eventName = activityDictionary[@"event_name"];
//        _eventDescription = activityDictionary[@"event_description"];
//        _eventLocation = activityDictionary[@"event_location"];
//        _eventTime  = activityDictionary[@"event_time"];
//        _eventExpired  =  (BOOL)  activityDictionary[@"event_expired"];
//        _statusCode = (NSInteger) activityDictionary[@"status_code"];;
//    }
//    return self;
//}

+ (NSMutableArray *)parseJSONDataIntoActivities: (NSData *)rawJSONData {
    NSError *error = nil;
    NSMutableArray *activities = [[NSMutableArray alloc]init];
    NSDictionary *searchJSONDictionary = [NSJSONSerialization JSONObjectWithData:rawJSONData options:0 error:&error];
    
    for (NSDictionary *itemsDictionary in searchJSONDictionary[@"events_created"]) {
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
