//
//  UserLoginRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserLoginRequest.h"

@implementation UserLoginRequest

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetUserRequestType_Login;
    }
    return self;
}


- (ASIHTTPRequest *) _httpRequest
{
    NSURL* url = [NSURL URLWithString:self.requestUrl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.actionCode forKey:@"action"];
    
    [request addPostValue:_divToken forKey:@"dev_id"];
    
    [request addPostValue:_userName forKey:@"username"];
    [request addPostValue:_password  forKey:@"password"];
    
    return request;
}


- (void) _requestFinished
{
    // 数据处理
    NSLog(@"nickname : %@", self.responseData.loginResponse.userInfo.nickName);
    
    [self.delegate NetUserRequestSuccess:self];
}

@end
