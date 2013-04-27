//
//  NetFileRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-27.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRequest.h"

typedef enum
{
    NetFileRequestType_Upload   = 0,
    NetFileRequestType_Download = 1,
    
    NetFileRequestType_Max      = 2,
} NetFileRequestType;


@class NetFileRequest;
@protocol NetFileRequestDelegate <NSObject>
- (void) NetFileRequestFail:(NetFileRequest *)request;
- (void) NetFileRequestSuccess:(NetFileRequest *)request;
@end


@interface NetFileRequest : NetRequest

@property (weak,     nonatomic) id<NetFileRequestDelegate>      delegate;

@property (assign,   nonatomic) NetFileRequestType              requestType;

@end
