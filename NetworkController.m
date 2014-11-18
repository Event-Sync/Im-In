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
//    _configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
//    _session = [NSURLSession sessionWithConfiguration:_configuration];
    
    [self setConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
    [self setSession: [NSURLSession sessionWithConfiguration: _configuration]];return self;
//    [self setAuthToken: @"Test"];
}

- (void) dealloc {
    
}

//
//https://iamin.herokuapp.com/Event/_123123
//.post(/api/newEvent)-to make new event -  Sam
//.get('/api/Event/_id')-to retrieve an event
//.delete('/api/Event/delete/_id')-to delete event - Matt
//.put('/api/Event/_id')-to update event
//.get('/api/Event/)-retrieve all events - Sam
//
//NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//NSString *path = [bundle pathForResource:@"questions" ofType:@"json"];
//XCTAssertNotNil(path, @"fail to locate questions.json file");
//
//NSData *jsonData = [NSData dataWithContentsOfFile:path];
//XCTAssertNotNil(jsonData, @"fail to load JSON file");
//
//NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//XCTAssertNotNil(jsonDict, @"jsonData is nil");
//
//NSArray *jsonArray = jsonDict[@"items"];
//XCTAssertTrue([jsonArray isKindOfClass:[NSArray class]], @"JSON file is not an array class");


- (void) fetchEventWithCompletion: (NSString *) eventId completionHandler: (void(^) (NSError *error, NSMutableArray *activies)) completionHandler {
    NSString *urlString = [NSString stringWithFormat: @"%@%@%@",kAPI, @"Event/_", eventId];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [_session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSInteger statusCode = httpResponse.statusCode;
            
            if (statusCode >= 200 && statusCode <= 299) {
                // need to declare a activity mutable array
                NSMutableArray *activities = [Activity parseJSONDataIntoActivities:data];
                
                // return to main queue
                [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                    completionHandler(nil, activities);
                }];
            }
        }
    }];
    [dataTask resume];
}

- (void) fetchAllEventsWithCompletion: (void(^) (NSError *error, NSMutableArray *activies)) completionHandler {
    
    NSString *urlString = [NSString stringWithFormat: @"%@%@",kAPI, @"Event/"];

    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [_session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSInteger statusCode = httpResponse.statusCode;
            
            if (statusCode >= 200 && statusCode <= 299) {
                // need to declare a activity mutable array
                NSMutableArray *activities = [Activity parseJSONDataIntoActivities:data];
                
                // return to main queue
                [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                    completionHandler(nil, activities);
                }];
            }
        }
     }];
    [dataTask resume];
}

- (void) createNewEventWithCompletion: (NSDictionary *) newEventDictionary completionHandler: (void(^) (NSError *error, BOOL response)) completionHandler  {
    
    NSString *urlString = [NSString stringWithFormat: @"%@%@",kAPI, @"newEvent"];

    NSURL *url = [NSURL URLWithString:urlString];
    
    NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:@"user", @"username",
                              @"password", @"password", nil];
    
    NSData *postData = [self encodeDictionary:postDict];
    
    // Create the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
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


- (NSData *)encodeDictionary:(NSDictionary *)dictionary {
    
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}



@end
