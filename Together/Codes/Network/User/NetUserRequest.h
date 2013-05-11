//
//  NetUserRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRequest.h"

typedef enum
{
    NetUserRequestType_Register     = 0,
    NetUserRequestType_Login        = 1,
    NetUserRequestType_ViewInfo     = 2,
    NetUserRequestType_ModifyInfo   = 3,
    NetUserRequestType_Follow       = 4,
    NetUserRequestType_UnFollow     = 5,
    NetUserRequestType_Zan          = 6,
    NetUserRequestType_FollowList   = 7,
    NetUserRequestType_FansList     = 8,
    NetUserRequestType_Max          = 9,
} NetUserRequestType;


@class NetUserRequest;
@protocol NetUserRequestDelegate <NSObject>
@optional
- (void) NetUserRequestFail:(NetUserRequest*)request;
- (void) NetUserRequestSuccess:(NetUserRequest*)request;
@end


@interface NetUserRequest : NetRequest

@property (weak,     nonatomic) id <NetUserRequestDelegate>     delegate;

@property (assign,   nonatomic) NetUserRequestType              requestType;
@property (readonly, nonatomic) NSString*                       requestUrl;
@property (readonly, nonatomic) NSString*                       actionCode;

@end
