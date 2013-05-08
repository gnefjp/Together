//
//  UserPersonInfoRequest.m
//  Together
//
//  Created by APPLE on 13-5-8.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserPersonInfoRequest.h"
#import "GEMTUserManager.h"
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
    [request addPostValue:[[GEMTUserManager shareInstance] getUserInfo].userId
                   forKey:@"self_uid"];
    [request addPostValue:self.aUid forKey:@"visit_uid"];
    [request addPostValue:[[GEMTUserManager shareInstance] sId]  forKey:@"sid"];
    return request;
}

- (void) _requestFinished
{
    // 数据处理
    NSLog(@"uid : %d", self.responseData.detailResponse.userInfo.uid);
    [self.delegate NetUserRequestSuccess:self];
}

@end
