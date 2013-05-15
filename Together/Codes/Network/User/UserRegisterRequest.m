//
//  UserRegisterRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserRegisterRequest.h"

@implementation UserRegisterRequest

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetUserRequestType_Register;
    }
    return self;
}


- (ASIHTTPRequest *) _httpRequest
{
    NSString *str = [NSString stringWithFormat:@"%@?action=%@&userName=%@&password=%@",self.requestUrl,self.actionCode,_userName,_password];
    NSURL* url = [NSURL URLWithString:str];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
//    [request addPostValue:self.actionCode forKey:@"action"];
//    [request addPostValue:_userName forKey:@"username"];
//    [request addPostValue:_password  forKey:@"password"];
    
    return request;
}

@end
