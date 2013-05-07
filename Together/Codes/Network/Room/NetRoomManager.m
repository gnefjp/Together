//
//  NetRoomManager.m
//  Together
//
//  Created by Gnef_jp on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRoomManager.h"

@implementation NetRoomManager

static NetRoomManager* s_defaultManager = nil;
+ (NetRoomManager*) defaultManager
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
        _roomList = [[NetRoomList alloc] init];
    }
    return self;
}

@end
