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
    return @"http://192.168.1.150:9080/USER";
}

- (NSString *) actionCode
{
    int actionCodes[] = {
        USER_REGIEST,
        USER_LOGIN,
        USER_VIEW_INFO,
        USER_SET_INFO,
        USER_FOLLOW,
        USER_UNFOLLOW,
        USER_PRISE,
        GET_FOLLOW_LIST,
        GET_FOLLOWED_LIST,
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
