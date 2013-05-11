//
//  UserFollowRequest.m
//  Together
//
//  Created by APPLE on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserFollowRequest.h"
#import "GEMTUserManager.h"

@implementation UserFollowRequest
@synthesize followId = _followId;

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetUserRequestType_Follow;
    }
    return self;
}

- (ASIHTTPRequest *) _httpRequest
{
    NSURL* url = [NSURL URLWithString:self.requestUrl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.actionCode forKey:@"action"];
    [request addPostValue:self.followId forKey:@"followed_id"];
    [request addPostValue:[[GEMTUserManager defaultManager] sId]  forKey:@"sid"];
    return request;
}

@end
