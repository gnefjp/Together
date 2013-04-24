//
//  NetUserRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetUserRequest.h"

@implementation NetUserRequest

- (NSString *) requestUrl
{
    return @"http://172.18.18.160:9080/USER";
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
    [self.delegate NetUserRequestSuccess:self];
}


- (void) _requestFailed
{
    [self.delegate NetUserRequestFail:self];
}

@end
