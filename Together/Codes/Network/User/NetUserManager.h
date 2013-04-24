//
//  NetUserManager.h
//  Together
//
//  Created by Gnef_jp on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserRegisterRequest.h"
#import "UserLoginRequest.h"

@interface NetUserManager : NSObject
{
    NSMutableArray*     _requestList;
}

+ (NetUserManager *) defaultManager;

- (void) removeDelete:(id)delegate;


// 请求
- (void) registWithRequest:(UserRegisterRequest *)request delegate:(id)delegate;
- (void) loginWithRequest:(UserLoginRequest *)request delegate:(id)delegate;

@end
