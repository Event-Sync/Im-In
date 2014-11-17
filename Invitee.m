//
//  Invitee.m
//  I'm In
//
//  Created by Sam Wong on 17/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "Invitee.h"

@interface Invitee()
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *telephone;
@end

@implementation Invitee

- (instancetype) initWithDictionary: (NSDictionary *) inviteeDictionary {
    if (self = [super init]) {
        self.name = @"name";
        self.telephone = @"telephone";
    }
    
    return self;
}

- (NSMutableArray *)parseJSONDataIntoInvitees: (NSData *)rawJSONData {
    NSError *error = nil;
    NSMutableArray *invitees = [[NSMutableArray alloc]init];
    NSDictionary *searchJSONDictionary = [NSJSONSerialization JSONObjectWithData:rawJSONData options:0 error:&error];
    
    for (NSDictionary *itemsDictionary in searchJSONDictionary[@"items"]) {
        Invitee *inviteeObject = [[Invitee alloc] initWithDictionary: itemsDictionary];
        [invitees addObject: inviteeObject];
    }
    return invitees;
}

@end
