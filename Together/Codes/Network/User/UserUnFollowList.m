//
//  UserUnFollowList.m
//  Together
//
//  Created by APPLE on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserUnFollowList.h"
#import "GEMTUserManager.h"

@implementation UserUnFollowList

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetUserRequestType_UnFollowList;
    }
    return self;
}

- (ASIHTTPRequest *) _httpRequest
{
    NSURL* url = [NSURL URLWithString:self.requestUrl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.actionCode
                   forKey:@"action"];
    [request addPostValue:[NSNumber numberWithInt:1]
                   forKey:@"page_no"];
    [request addPostValue:[NSNumber numberWithInt:100]
                   forKey:@"page_size"];
    [request addPostValue:[[GEMTUserManager defaultManager] sId]
                   forKey:@"sid"];
    return request;
}

@end
