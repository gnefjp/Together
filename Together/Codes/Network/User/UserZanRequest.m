//
//  UserZanRequest.m
//  Together
//
//  Created by APPLE on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserZanRequest.h"
#import "GEMTUserManager.h"

@implementation UserZanRequest

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetUserRequestType_Zan;
    }
    return self;
}

- (ASIHTTPRequest *) _httpRequest
{
    NSURL* url = [NSURL URLWithString:self.requestUrl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.actionCode forKey:@"action"];
    [request addPostValue:@"1"
                   forKey:@"uid"];
    [request addPostValue:[[GEMTUserManager shareInstance] sId]  forKey:@"sid"];
    return request;
}

@end
