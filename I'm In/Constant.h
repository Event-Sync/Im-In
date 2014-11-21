//
//  Constant.h
//  I'm In
//
//  Created by Sam Wong on 17/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#ifndef I_m_In_Constant_h
#define I_m_In_Constant_h

NSString * const kAPI = @"https://iamin.herokuapp.com/v1/api/";
NSString * const kAuthToken = @"authToken";

NSString * const kAPIgetAllEventsPath = @"event";
NSString * const kAPIgetSingleEventPath = @"event/"; //expect event_id
NSString * const kAPIupdateEventPath = @"event/put";
NSString * const kAPIdeleteEventPath = @"event/delete";
NSString * const kAPInewEventPath = @"newEvent";


#endif
