//
//  RoomGetListRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomGetListRequest.h"

@implementation RoomGetListRequest


- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetRoomRequestType_GetRooms;
    }
    return self;
}


- (ASIHTTPRequest *) _httpRequest
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.actionCode forKey:@"action"];
    [dict setValue:[NSString stringWithInt:self.roomType] forKey:@"roomType"];
    
    [dict setValue:[NSString stringWithDouble:self.location.longitude] forKey:@"longitude"];
    [dict setValue:[NSString stringWithDouble:self.location.latitude] forKey:@"latitude"];
    [dict setValue:[NSString stringWithFloat:self.range] forKey:@"range"];
    
    [dict setValue:[NSString stringWithInt:self.pageNum + 1] forKey:@"pageNo"];
    [dict setValue:[NSString stringWithInt:self.pageSize] forKey:@"pageSize"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",
                        self.requestUrl, [NSString urlArgsStringFromDictionary:dict]];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    
    return request;
}

@end
