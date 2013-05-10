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
    [request addPostValue:@"1" forKey:@"unfollowed_id"];
    
    [request addPostValue:[[GEMTUserManager shareInstance] sId]
                   forKey:@"sid"];
    return request;
}

@end
