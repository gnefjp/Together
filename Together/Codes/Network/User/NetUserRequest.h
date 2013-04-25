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
    
    NetUserRequestType_Max          = 2,
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