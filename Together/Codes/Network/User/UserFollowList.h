//
//  UserFollowList.h
//  Together
//
//  Created by APPLE on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetUserRequest.h"

@interface UserFollowList : NetUserRequest
{
    NSString            *_requestUserId;
    
}

@property (strong , nonatomic)  NSString  *requestUserId;
@end
