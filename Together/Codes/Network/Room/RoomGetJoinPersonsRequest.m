//
//  RoomGetJoinPersonsRequest.m
//  Together
//
//  Created by Gnef_jp on 13-5-15.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomGetJoinPersonsRequest.h"

@implementation RoomGetJoinPersonsRequest

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetRoomRequestType_JoinPersons;
    }
    return self;
}


- (ASIHTTPRequest *) _httpRequest
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.actionCode forKey:@"action"];
    [dict setValue:self.roomID forKey:@"roomId"];
    
    [dict setValue:[NSString stringWithInt:self.pageSize] forKey:@"pageSize"];
    [dict setValue:[NSString stringWithInt:self.pageNum + 1] forKey:@"pageNo"];
    
    [dict setValue:self.sid forKey:@"sid"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",
                        self.requestUrl, [NSString urlArgsStringFromDictionary:dict]];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    
    return request;
}


@end
