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
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.actionCode forKey:@"action"];
    [dict setValue:self.aUid forKey:@"visit_uid"];
    [dict setValue:[[GEMTUserManager defaultManager] sId] forKey:@"sid"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",
                        self.requestUrl, [NSString urlArgsStringFromDictionary:dict]];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    return request;
}

- (void) _requestFinished
{
    // 数据处理
    NSLog(@"uid : %d", self.responseData.detailResponse.userInfo.uid);
    [self.delegate NetUserRequestSuccess:self];
}

@end
