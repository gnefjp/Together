//
//  RoomQuitReqeust.m
//  Together
//
//  Created by Gnef_jp on 13-5-15.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomQuitReqeust.h"

@implementation RoomQuitReqeust


- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetRoomRequestType_QuitRoom;
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
