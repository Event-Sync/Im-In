//
//  NetworkController.h
//  EventSync
//
//  Created by Sam Wong on 17/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkController : NSObject
@property (nonatomic, strong) NSString *authToken;
+ (id) sharedInstance;
- (void) fetchActivities:completionHandler: (void(^) (NSError *error, NSMutableArray *response)) completionHandler;
- (void) createNewActivity:completionHandler: (void(^) (NSError *error, NSMutableArray *response)) completionHandler;
@end
