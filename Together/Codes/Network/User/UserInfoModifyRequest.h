//
//  UserInfoModify.h
//  Together
//
//  Created by APPLE on 13-5-8.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetUserRequest.h"

@interface UserInfoModifyRequest : NetUserRequest
{
    NSString            *_avatarId;
    NSString            *_recordId;
    NSString            *_nickName;
    NSString            *_sex;
    NSString            *_sign;
    NSString            *_birthDay;
}

@property (strong , nonatomic) NSString            *avatarId;
@property (strong , nonatomic) NSString            *recordId;
@property (strong , nonatomic) NSString            *nickName;

@property (strong , nonatomic) NSString            *sign;
@property (strong , nonatomic) NSString            *birthDay;
@property (strong , nonatomic) NSString            *sex;

@end
