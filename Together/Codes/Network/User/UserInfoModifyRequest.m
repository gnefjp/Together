//
//  UserInfoModify.m
//  Together
//
//  Created by APPLE on 13-5-8.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserInfoModifyRequest.h"

@implementation UserInfoModifyRequest

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetUserRequestType_ModifyInfo;
    }
    return self;
}

- (ASIHTTPRequest *) _httpRequest
{
    NSURL* url = [NSURL URLWithString:self.requestUrl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.actionCode forKey:@"action"];
    [request addPostValue:@"cababa" forKey:@"nickname"];
    [request addPostValue:@"b4941b8eaa0bddfa611656788ac48078" forKey:@"sid"];
    return request;
}

- (void) _requestFinished
{
    // 数据处理
    [self.delegate NetUserRequestSuccess:self];
}

@end
