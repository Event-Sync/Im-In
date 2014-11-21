//
//  ActivityProtocolDelegate.m
//  I'm In
//
//  Created by Sam Wong on 20/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "ActivityProtocol.h"

@implementation ActivityProtocol

- (void) startSampleProcess {
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self.delegate selector:@selector(processCompleted) userInfo:nil repeats:NO];
}

@end
