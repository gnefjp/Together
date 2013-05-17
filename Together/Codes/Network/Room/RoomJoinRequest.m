//
//  RoomJoinRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomJoinRequest.h"

@implementation RoomJoinRequest


#ifdef kIsSimulatedData
- (NSString *) requestUrl
{
    return @"http://127.0.0.1/ROOM/JoinRoom";
}
#endif


- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetRoomRequestType_JoinRoom;
    }
    return self;
}


- (ASIHTTPRequest *) _httpRequest
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setValue:self.actionCode forKey:@"action"];
    [dict setValue:self.roomID forKey:@"roomId"];
    [dict setValue:self.userID forKey:@"userId"];
    [dict setValue:self.sid forKey:@"sid"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",
                        self.requestUrl, [NSString urlArgsStringFromDictionary:dict]];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    
    return request;
}

@end
