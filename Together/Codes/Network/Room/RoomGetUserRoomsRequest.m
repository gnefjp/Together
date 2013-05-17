//
//  RoomGetUserRommsRequest.m
//  Together
//
//  Created by Gnef_jp on 13-5-15.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomGetUserRoomsRequest.h"

@implementation RoomGetUserRoomsRequest


#ifdef kIsSimulatedData
- (NSString *) requestUrl
{
    return @"http://127.0.0.1/ROOM/GetUserRooms";
}
#endif


- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetRoomRequestType_GetUserRooms;
    }
    return self;
}


- (ASIHTTPRequest *) _httpRequest
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.actionCode forKey:@"action"];
    [dict setValue:[NSString stringWithInt:self.roomStatus] forKey:@"roomType"];
    [dict setValue:[NSString stringWithInt:self.isMyRoom] forKey:@"showType"];
    
    [dict setValue:[NSString stringWithInt:self.pageNum + 1] forKey:@"pageNo"];
    [dict setValue:[NSString stringWithInt:self.pageSize] forKey:@"pageSize"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",
                        self.requestUrl, [NSString urlArgsStringFromDictionary:dict]];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    
    return request;
}

@end
