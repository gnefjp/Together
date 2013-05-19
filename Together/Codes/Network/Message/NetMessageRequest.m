//
//  NetMessagetRequest.m
//  Together
//
//  Created by Gnef_jp on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetMessageRequest.h"

@implementation NetMessageRequest

- (NSString *) requestUrl
{
    return [NSString stringWithFormat:@"http://%@:%@/MESSAGE", kServerAddr, kHttpPort];
}


- (NSString *) actionCode
{
    int actionCodes[] = {
        GET_MSG,
        
        GET_MSG_LIST,
        
        CHANGE_MSG_STATUS,
    };
    
    return [NSString stringWithFormat:@"%d", actionCodes[_requestType]];
}


- (void) _requestFinished
{
    [self.delegate NetMessageRequestSuccess:self];
}


- (void) _requestFailed
{
    [self.delegate NetMessageRequestFail:self];
}

@end
