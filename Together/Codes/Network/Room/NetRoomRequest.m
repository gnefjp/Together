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
    return @"http://127.0.0.1/ROOM";
}

- (NSString *) actionCode
{
    int actionCodes[] = {
        USER_REGIEST,
        USER_LOGIN,
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
