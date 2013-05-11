//
//  UserUnFollowRequest.m
//  Together
//
//  Created by APPLE on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserUnFollowRequest.h"
#import "GEMTUserManager.h"

@implementation UserUnFollowRequest
@synthesize unFollowId = _unFollowId;

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetUserRequestType_UnFollow;
    }
    return self;
}

- (ASIHTTPRequest *) _httpRequest
{
    NSURL* url = [NSURL URLWithString:self.requestUrl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.actionCode forKey:@"action"];
    [request addPostValue:_unFollowId forKey:@"uid"];
    
    [request addPostValue:[[GEMTUserManager defaultManager] sId]
                   forKey:@"sid"];
    return request;
}

@end
