//
//  UserUnFollowList.m
//  Together
//
//  Created by APPLE on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserFansList.h"
#import "GEMTUserManager.h"

@implementation UserFansList
@synthesize fansUserId = _fansUserId;

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetUserRequestType_FansList;
    }
    return self;
}

- (ASIHTTPRequest *) _httpRequest
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.actionCode forKey:@"action"];
    [dict setValue:[NSString stringWithInt:1] forKey:@"page_no"];
    [dict setValue:[NSString stringWithInt:100] forKey:@"page_size"];
    
    [dict setValue:[[GEMTUserManager defaultManager] sId] forKey:@"sid"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",
                        self.requestUrl, [NSString urlArgsStringFromDictionary:dict]];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    return request;
}

@end
