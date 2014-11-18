//
//  Activity.m
//  I'm In
//
//  Created by Sam Wong on 17/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "Activity.h"
#import "Invitee.h"

@interface Activity()
@property (nonatomic) NSInteger activityID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) Invitee *invitess;
@end

@implementation Activity

- (instancetype) initWithDictionary: (NSDictionary *) activityDictionary {
    if (self = [super init]) {
        self.title = @"title";
        self.description = @"description";
        self.location = @"location";
        //self.time =;
    }
    
    return self;
}

+ (NSMutableArray *)parseJSONDataIntoActivities: (NSData *)rawJSONData {
    NSError *error = nil;
    NSMutableArray *activities = [[NSMutableArray alloc]init];
    NSDictionary *searchJSONDictionary = [NSJSONSerialization JSONObjectWithData:rawJSONData options:0 error:&error];
    
    for (NSDictionary *itemsDictionary in searchJSONDictionary[@"items"]) {
        Activity *activityObject = [[Activity alloc] initWithDictionary: itemsDictionary];
        [activities addObject: activityObject];
    }
    return activities;
}

@end
