//
//  RoomSearchRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomSearchRequest.h"

@implementation RoomSearchRequest

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetRoomRequestType_SearchRooms;
    }
    return self;
}


- (ASIHTTPRequest *) _httpRequest
{
    NSURL* url = [NSURL URLWithString:self.requestUrl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.actionCode forKey:@"action"];
    
    
    return request;
}

@end