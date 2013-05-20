//
//  MessageUpdateStateRequest.m
//  Together
//
//  Created by Gnef_jp on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "MessageUpdateStateRequest.h"

@implementation MessageUpdateStateRequest

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetMessageRequestType_UpdateState;
    }
    return self;
}


- (ASIHTTPRequest *) _httpRequest
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setValue:self.actionCode forKey:@"action"];
    [dict setValue:self.roomID forKey:@"room_id"];
    [dict setValue:self.recipientId forKey:@"recipient_id"];
    [dict setValue:self.msgID forKey:@"msg_id"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",
                        self.requestUrl, [NSString urlArgsStringFromDictionary:dict]];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    
    return request;
}

@end
