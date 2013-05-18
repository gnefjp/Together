//
//  UserFollowList.m
//  Together
//
//  Created by APPLE on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserFollowList.h"
#import "GEMTUserManager.h"

@implementation UserFollowList
@synthesize requestUserId = _requestUserId;

- (id) init
{
    self = [super init];
    if (self)
    {  
        self.requestType = NetUserRequestType_FollowList;
    }
    return self;
}

- (ASIHTTPRequest *) _httpRequest
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.actionCode forKey:@"action"];
    [dict setValue:[NSString stringWithInt:1] forKey:@"page_no"];
    [dict setValue:[NSString stringWithInt:100] forKey:@"page_size"];
    [dict setValue:_requestUserId forKey:@"uid"];
    [dict setValue:[GEMTUserManager defaultManager].sId forKey:@"sid"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",
                        self.requestUrl, [NSString urlArgsStringFromDictionary:dict]];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    return request;

}

@end
