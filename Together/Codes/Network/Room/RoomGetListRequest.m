//
//  RoomGetListRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomGetListRequest.h"

@implementation RoomGetListRequest

//- (NSString *) requestUrl
//{
//    return @"http://192.168.1.102/ROOM";
//}


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
    NSURL* url = [NSURL URLWithString:self.requestUrl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.actionCode forKey:@"action"];
    [request addPostValue:[NSString stringWithInt:self.roomType] forKey:@"roomType"];
    
    [request addPostValue:[NSString stringWithDouble:self.location.longitude] forKey:@"longitude"];
    [request addPostValue:[NSString stringWithDouble:self.location.latitude] forKey:@"latitude"];
    [request addPostValue:[NSString stringWithFloat:self.range] forKey:@"range"];
    
    [request addPostValue:[NSString stringWithInt:self.pageNum + 1] forKey:@"pageNo"];
    [request addPostValue:[NSString stringWithInt:self.pageSize] forKey:@"pageSize"];
    
    return request;
}

@end
