//
//  UserLoginRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserLoginRequest.h"

@implementation UserLoginRequest

#ifdef kIsSimulatedData
- (NSString *) requestUrl
{
    return @"http://127.0.0.1/USER/Login";
}
#endif


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
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.actionCode forKey:@"action"];
    [dict setValue:_divToken forKey:@"dev_id"];
    [dict setValue:_userName forKey:@"username"];
    [dict setValue:_password forKey:@"password"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",
                        self.requestUrl, [NSString urlArgsStringFromDictionary:dict]];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    return request;
}


- (void) _requestFinished
{
    // 数据处理
    NSLog(@"nickname : %@", self.responseData.loginResponse.userInfo.nickName);
    
    [self.delegate NetUserRequestSuccess:self];
}

@end
