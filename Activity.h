//
//  Activity.h
//  I'm In
//
//  Created by Sam Wong on 17/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject

- (instancetype) initWithDictionary: (NSDictionary *) activityDictionary;
+ (NSMutableArray *) parseJSONDataIntoActivities: (NSData *)rawJSONData;

@end
