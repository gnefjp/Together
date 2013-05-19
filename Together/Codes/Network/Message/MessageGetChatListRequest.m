//
//  MessageGetChatListRequest.m
//  Together
//
//  Created by Gnef_jp on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "MessageGetChatListRequest.h"

@implementation MessageGetChatListRequest

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetMessageRequestType_GetChatList;
    }
    return self;
}


- (ASIHTTPRequest *) _httpRequest
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setValue:self.actionCode forKey:@"action"];
    [dict setValue:self.currentID forKey:@"current_id"];
    [dict setValue:[NSString stringWithInt:self.msgNum] forKey:@"msgs_num"];
    [dict setValue:self.recipientID forKey:@"recipient_id"];
    [dict setValue:self.roomID forKey:@"room_id"];
    [dict setValue:[NSString stringWithInt:self.getMessagetType] forKey:@"type"];
    [dict setValue:[NSString stringWithInt:self.getListDirect] forKey:@"get_type"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",
                        self.requestUrl, [NSString urlArgsStringFromDictionary:dict]];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    
    return request;
}

@end
