//
//  NetworkController.m
//  EventSync
//
//  Created by Sam Wong on 17/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "NetworkController.h"
#import "Constant.h"
#import <UIKit/UIKit.h>
#import "Activity.h"

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
    self = [super init];
    
    if (self) {
        if (_authToken == nil) {
            _authToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"authToken"];
        }
    }
    return self;
}

- (void) dealloc {
    
}

- (void) fetchSingleEventUsingPath: (NSString *) eventId completionHandler: (void(^) (NSError *error, Activity *response)) completionHandler {
    NSString *pathToJSON = [[NSBundle mainBundle] pathForResource:@"activity" ofType:@"json"];
    NSData *JSONEventData = [NSData dataWithContentsOfFile:pathToJSON];

    Activity *activity = [Activity parseJSONDataIntoActivity:JSONEventData];
    
    completionHandler(nil, activity);
}

- (void) fetchAllEventsUsingPath: (void(^) (NSError *error, NSMutableArray *response)) completionHandler {
    NSString *pathToJSON = [[NSBundle mainBundle] pathForResource:@"allactivities" ofType:@"json"];
    NSData *JSONEventData = [NSData dataWithContentsOfFile:pathToJSON];
    
    NSMutableArray *eventArray = [[NSMutableArray alloc] init];
    eventArray = [Activity parseJSONDataIntoActivities:JSONEventData];
    
    completionHandler(nil, eventArray);
}

- (void) fetchEventWithCompletion: (NSString *) eventId completionHandler: (void(^) (NSError *error, Activity *response)) completionHandler {
    
    NSString *urlString = [NSString stringWithFormat: @"%@%@%@?jwt=%@",kAPI, kAPIgetSingleEventPath, eventId, _authToken];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                NSLog(@"HTTP Error: %ld %@", (long)httpResponse.statusCode, error);
            } else {
                NSLog(@"Error %@", error.localizedDescription);
            }
            
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSInteger statusCode = httpResponse.statusCode;
            
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", responseString);
            
            if ([response isKindOfClass: [NSHTTPURLResponse class]]) {
                if (statusCode >= 200 && statusCode <= 299) {
                    // need to declare a activity mutable array
                    Activity *activity = [Activity parseJSONDataIntoActivity:data];
                    
                    // return to main queue
                    [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                        completionHandler(nil, activity);
                    }];
                } else {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completionHandler (error, nil);
                    }];
                }
            }
            

        }
    }];
    [dataTask resume];
}

- (void) fetchAllEventsWithCompletion: (NSDictionary *) eventDictionary completionHandler: (void(^) (NSError *error, NSMutableArray *response)) completionHandler {
    
//    NSString *urlString = [NSString stringWithFormat: @"%@%@",kAPI, kAPIgetAllEventsPath];
//    //https://iamin.herokuapp.com/v1/api/
    
    
    NSString *urlString = [NSString stringWithFormat: @"%@%@?jwt=%@",kAPI, kAPIgetAllEventsPath, _authToken];

    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSLog(@"%@", url);
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:eventDictionary options:0 error:nil];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error != nil) {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                NSLog(@"HTTP Error: %ld %@", (long)httpResponse.statusCode, error);
            } else {
                NSLog(@"Error %@", error.localizedDescription);
            }
 
        } else {
            
            if (response != nil) {
                if ([response isKindOfClass: [NSHTTPURLResponse class]]) {
                    
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                    NSInteger statusCode = httpResponse.statusCode;
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"%@", responseString);
                    
                    if (statusCode >= 200 && statusCode <= 299) {
                        // need to declare a activity mutable array
                        NSMutableArray *activities = [Activity parseJSONDataIntoActivities:data];
                        
                        // return to main queue
                        [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                            completionHandler(nil, activities);
                        }];
                    } else {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            completionHandler (error, nil);
                        }];
                    }
                }
                
            }
            

        }
    }];
    [dataTask resume];
}

- (void) createNewEventWithCompletion: (NSDictionary *) newEventDictionary completionHandler: (void(^) (NSError *error, BOOL response)) completionHandler  {
    
    NSString *urlString = [NSString stringWithFormat: @"%@%@", kAPI, kAPInewEventPath];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:newEventDictionary options:0 error:nil];
    
    // Create the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error != nil) {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                NSLog(@"HTTP Error: %ld %@", (long)httpResponse.statusCode, error);
                return;
            }
            NSLog(@"Error %@", error.localizedDescription);
            return;
        }
        
        if (response != nil) {
            if ([response isKindOfClass: [NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                
                if (httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completionHandler (nil, YES);
                    }];
                } else {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completionHandler (error, NO);
                    }];
                }
            }
            
        }
        
    }];
    [dataTask resume];
    
}

- (void) createAccountWithCompletion: (NSDictionary *)  accountInfo completionHandler: (void(^) (NSError *error, BOOL response)) completionHandler {
    
    NSString *urlString = [NSString stringWithFormat: @"%@%@", @"https://iamin.herokuapp.com/", @"login/newUser"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:accountInfo options:0 error:nil];
    
    // Create the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error != nil) {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                NSLog(@"HTTP Error: %ld %@", (long)httpResponse.statusCode, error);
                return;
            }
            NSLog(@"Error %@", error);
            return;
        }
        
        if (response != nil) {
            if ([response isKindOfClass: [NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@", responseString);
                
                if (httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299) {
                    NSDictionary *searchJSONDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    
                    if (searchJSONDictionary != nil) {
                        _authToken = searchJSONDictionary[@"jwt"];
                        [[NSUserDefaults standardUserDefaults] setObject:_authToken forKey:kAuthToken];
                    }
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completionHandler (nil, YES);
                    }];
                } else {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completionHandler (error, NO);
                    }];
                }
            }
            
        }
        
    }];
    [dataTask resume];
    
}

- (void) loginWithCompletion: (NSDictionary *)  accountInfo completionHandler: (void(^) (NSError *error, BOOL response)) completionHandler {
    
    NSString *urlString = [NSString stringWithFormat: @"%@%@", @"https://iamin.herokuapp.com/", @"login"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:accountInfo options:0 error:nil];
    
    // Create the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error != nil) {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                NSLog(@"HTTP Error: %ld %@", (long)httpResponse.statusCode, error);
                return;
            }
            NSLog(@"Error %@", error);
            return;
        }
        
        if (response != nil) {
            if ([response isKindOfClass: [NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@", responseString);
                
                if (httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299) {
                    NSDictionary *searchJSONDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    
                    if (searchJSONDictionary != nil) {
                        _authToken = searchJSONDictionary[@"jwt"];
                        [[NSUserDefaults standardUserDefaults] setObject:_authToken forKey:kAuthToken];
                    }
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completionHandler (nil, YES);
                    }];
                } else {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completionHandler (error, NO);
                    }];
                }
            }
            
        }
        
    }];
    [dataTask resume];
    
}



@end
