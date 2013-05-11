//
//  UserFollowRequest.h
//  Together
//
//  Created by APPLE on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetUserRequest.h"

@interface UserFollowRequest : NetUserRequest
{
    NSString            *_followId;
}

@property (nonatomic, retain)  NSString            *followId;

@end
