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

//https://iamin.herokuapp.com/
//.post(/v1/api/newEvent)-to make new event
//.get(/v1/api/Event/eventId?jwt=sfsdfsd)-to retrieve an event
//.delete(/v1/api/Event/delete/)-to delete event
//.put('/v1/api/Event/)-to update event
//.get('/v1/api/Event/)-retrieve all events

NSString * const kAPIgetAllEventsPath = @"event";
NSString * const kAPIgetSingleEventPath = @"event/"; //expect event_id
NSString * const kAPIupdateEventPath = @"event/put";
NSString * const kAPIdeleteEventPath = @"event/delete";
NSString * const kAPInewEventPath = @"newEvent";


#endif
