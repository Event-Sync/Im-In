//
//  NetworkController.m
//  EventSync
//
//  Created by Sam Wong on 17/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "NetworkController.h"

@interface NetworkController()
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionConfiguration *configuration;
@end

@implementation NetworkController

+ (id) sharedInstance {
    static NetworkController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once( &onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

- (id) init {
//    _configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
//    _session = [NSURLSession sessionWithConfiguration:_configuration];
    
    [self setConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
    [self setSession: [NSURLSession sessionWithConfiguration: _configuration]];return self;
    [self setAuthToken: @"Test"];
}

- (void) dealloc {
    
}

- (void) fetchActivities:completionHandler: (void(^) (NSError *error, NSMutableArray *response)) completionHandler {
    NSString *urlString = nil;
    
    if (_authToken != nil) {
        urlString = [NSString stringWithFormat:@"https://www.twilio.com/advanced?access_token=@%", _authToken];
    } else {
        urlString = [NSString stringWithFormat:@"https://www.twilio.com/advanced"];
    }
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [_session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSInteger statusCode = httpResponse.statusCode;
            
            if (statusCode >= 200 && statusCode <= 299) {
                // need to declare a activity mutable array
                NSMutableArray *activities = nil;
                
                // return to main queue
                [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                    completionHandler(nil, activities);
                }];
            }
        }
     }];
    [dataTask resume];
}

- (void) createNewActivity: completionHandler: (void(^) (NSError *error, NSMutableArray *response)) completionHandler {
    NSString *urlString = nil;
    
    if (_authToken != nil) {
        urlString = [NSString stringWithFormat:@"https://www.twilio.com/advanced?access_token=@%", _authToken];
    } else {
        urlString = [NSString stringWithFormat:@"https://www.twilio.com/advanced"];
    }
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [_session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSInteger statusCode = httpResponse.statusCode;
            
            if (statusCode >= 200 && statusCode <= 299) {
                // need to declare a activity mutable array
                NSMutableArray *activities = nil;
                
                // return to main queue
                [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                    completionHandler(nil, activities);
                }];
            }
        }
    }];
    [dataTask resume];
}

@end
