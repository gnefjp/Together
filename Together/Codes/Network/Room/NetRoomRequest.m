//
//  NetRoomRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRoomRequest.h"

@implementation NetRoomRequest

- (NSString *) requestUrl
{
    return @"http://192.168.1.103:9080/ROOM";
}


- (NSString *) actionCode
{
    int actionCodes[] = {
        ROOM_CREATE,
        SHOW_ROOM_INFO,
        
        ROOM_JOIN,
        ROOM_QUIT,
        
        ROOM_SHOWLIST,
        SHOW_USER_ROOM,
        
        ROOM_PEOPLE_LIST,
    };
    
    return [NSString stringWithFormat:@"%d", actionCodes[_requestType]];
}


- (void) _requestFinished
{
    [self.delegate NetRoomRequestSuccess:self];
}


- (void) _requestFailed
{
    [self.delegate NetRoomRequestFail:self];
}

@end
