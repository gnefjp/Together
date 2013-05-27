//
//  NetMessagetRequest.h
//  Together
//
//  Created by Gnef_jp on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRequest.h"

typedef enum
{
    NetMessageRequestType_GetChatList   = 0,
    NetMessageRequestType_GetMessage    = 1,
    NetMessageRequestType_UpdateState   = 2,
    
    NetMessageRequestType_Max           = 3,
} NetMessageRequestType;

@class NetMessageRequest;
@protocol NetMessageRequestDelegate <NSObject>
- (void) NetMessageRequestFail:(NetRequest *)request;
- (void) NetMessageRequestSuccess:(NetRequest *)request;
@end


@interface NetMessageRequest : NetRequest

@property (weak,     nonatomic) id<NetMessageRequestDelegate>   delegate;

@property (assign,   nonatomic) NetMessageRequestType           requestType;

@end
