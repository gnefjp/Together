//
//  MessageGetListRequest.m
//  Together
//
//  Created by Gnef_jp on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "MessageGetListRequest.h"


@implementation MessageGetListRequest

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetMessageRequestType_GetMessage;
    }
    return self;
}


- (NSString *) requestUrl
{
#ifdef kIsSimulatedData
    return @"http://127.0.0.1/MESSAGE/GetMsgList";
#endif
    return [NSString stringWithFormat:@"http://%@:%@/USER", kServerAddr, kHttpPort];
}


- (ASIHTTPRequest *) _httpRequest
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setValue:self.actionCode forKey:@"action"];
    [dict setValue:self.recipinetID forKey:@"recipient_id"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",
                        self.requestUrl, [NSString urlArgsStringFromDictionary:dict]];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    
    return request;
}

@end
