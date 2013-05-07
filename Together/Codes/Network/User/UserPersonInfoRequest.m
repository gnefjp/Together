//
//  UserPersonInfoRequest.m
//  Together
//
//  Created by APPLE on 13-5-8.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserPersonInfoRequest.h"

@implementation UserPersonInfoRequest
@synthesize aUid;

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetUserRequestType_ViewInfo;
    }
    return self;
}

- (ASIHTTPRequest *) _httpRequest
{
    NSURL* url = [NSURL URLWithString:self.requestUrl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.actionCode forKey:@"action"];
    [request addPostValue:[NSNumber numberWithInt:1] forKey:@"self_uid"];
    [request addPostValue:[NSNumber numberWithInt:7] forKey:@"visit_uid"];
    [request addPostValue:@"b4941b8eaa0bddfa611656788ac48078" forKey:@"sid"];
    return request;
}

- (void) _requestFinished
{
    // 数据处理
    NSLog(@"uid : %d", self.responseData.detailResponse.userInfo.uid);
    [self.delegate NetUserRequestSuccess:self];
}

@end
