//
//  ActivityProtocolDelegate.h
//  I'm In
//
//  Created by Sam Wong on 20/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ActivityProtocolDelegate <NSObject>
@required
- (void) processCompleted;
@end;

@interface ActivityProtocol : NSObject {
    id <ActivityProtocolDelegate> _delegate;
}

@property (nonatomic, strong) id delegate;
-(void) startSampleProcess;
@end
