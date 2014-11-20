//
//  Attendee.m
//  I'm In
//
//  Created by Sam Wong on 19/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "Attendee.h"
#import <UIKit/UIKit.h>

@interface Attendee()

@end

@implementation Attendee

- (instancetype) initWithDictionary: (NSDictionary *) attendeeDictionary {
    if (self = [super init]) {
        _name = attendeeDictionary[@"name"];
        _telephoneNo = attendeeDictionary[@"phone_number"];
        _confirmedStatus = attendeeDictionary[@"confirmed"];
        _profileImage = nil;
    }
    return self;
}

- (NSMutableArray *)parseJSONDataIntoAttendees: (NSData *)rawJSONData {
    NSError *error = nil;
    NSMutableArray *Attendees = [[NSMutableArray alloc]init];
    NSDictionary *searchJSONDictionary = [NSJSONSerialization JSONObjectWithData:rawJSONData options:0 error:&error];
    
    for (NSDictionary *itemsDictionary in searchJSONDictionary[@"invitees"]) {
        Attendee *attendeeObject = [[Attendee alloc] initWithDictionary: itemsDictionary];
        [Attendees addObject: attendeeObject];
    }
    return Attendees;
}

@end

