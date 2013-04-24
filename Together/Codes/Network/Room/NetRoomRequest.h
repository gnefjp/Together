//
//  NetRoomRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRequest.h"

typedef enum
{
    NetRoomRequestType_CreateRoom   = 0,
    NetRoomRequestType_JoinRoom     = 1,
    
    NetRoomRequestType_GetRooms     = 2,
    NetRoomRequestType_SearchRooms  = 3,
    
} NetRoomRequestType;


@class NetRoomRequest;
@protocol NetRoomRequestDelegate <NSObject>
- (void) NetRoomRequestFail:(NetRoomRequest *)request;
- (void) NetRoomRequestSuccess:(NetRoomRequest *)request;
@end


@interface NetRoomRequest : NetRequest

@property (weak,     nonatomic) id<NetRoomRequestDelegate>      delegate;

@property (assign,   nonatomic) NetRoomRequestType              requestType;
@property (readonly, nonatomic) NSString*                       requestUrl;
@property (readonly, nonatomic) NSString*                       actionCode;

@end






