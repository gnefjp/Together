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
@synthesize unFollowId = _unFollowId;

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
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.actionCode forKey:@"action"];
    [dict setValue:_unFollowId forKey:@"uid"];
    [dict setValue:[[GEMTUserManager defaultManager] sId] forKey:@"sid"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",
                        self.requestUrl, [NSString urlArgsStringFromDictionary:dict]];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    return request;
}

@end
