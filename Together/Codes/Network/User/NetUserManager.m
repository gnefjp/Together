//
//  NetUserManager.m
//  Together
//
//  Created by Gnef_jp on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetUserManager.h"

@implementation NetUserManager

static NetUserManager* s_defaultManager = nil;
+ (NetUserManager*) defaultManager
{
    if (s_defaultManager == nil)
    {
        @synchronized(self)
        {
            if (s_defaultManager == nil)
            {
                s_defaultManager = [[self alloc] init];
            }
        }
    }
    
    return s_defaultManager;
}


- (id) init
{
    self = [super init];
    if (self)
    {
        _requestList = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void) removeDelete:(id)delegate
{
    for (NetUserRequest* request in _requestList)
    {
        if (request.managerDelegate == delegate)
        {
            [self _removeRequest:request];
        }
    }
}


#pragma mark- request
- (void) _removeRequest:(NetUserRequest *)request
{
    
}


- (void) registWithRequest:(UserRegisterRequest *)request delegate:(id)delegate
{
    
}


- (void) loginWithRequest:(UserLoginRequest *)request delegate:(id)delegate
{
    
}

@end
