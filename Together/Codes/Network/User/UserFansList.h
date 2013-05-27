//
//  UserUnFollowList.h
//  Together
//
//  Created by APPLE on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetUserRequest.h"

@interface UserFansList : NetUserRequest
{
    NSString            *_fansUserId;
}

@property (strong , nonatomic)  NSString            *fansUserId;

@end
