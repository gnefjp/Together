//
//  UserRegisterRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetUserRequest.h"

@interface UserRegisterRequest : NetUserRequest

@property (copy, nonatomic) NSString    *userName;
@property (copy, nonatomic) NSString    *password;

@end
