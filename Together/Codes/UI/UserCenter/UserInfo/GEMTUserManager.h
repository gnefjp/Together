//
//  GEMTUserManager.h
//  Together
//
//  Created by APPLE on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserConfig.h"
#import "GEMTUserInfo.h"
#import "UserLoginView.h"
#import "UserLoginRequest.h"

@class UserLoginView;

@interface GEMTUserManager : NSObject<UserLoginDelegate,NetUserRequestDelegate>
{
    BOOL                _isShowLoginView;
    GEMTUserInfo        *_userInfo;
    BOOL                _isLoginIng;
    BOOL                _isLogIn;
}

@property (strong , nonatomic) GEMTUserInfo        *userInfo;
@property (nonatomic)          BOOL                isLogIn;
- (GEMTUserInfo*)getUserInfo;
- (void)userName:(NSString*)aUserName passWord:(NSString*)aPassWord;


- (BOOL)shouldAddLoginViewToTopView;

- (void)autoLogin;
- (void)LogInWithUserName:(NSString*)userName
                 passWord:(NSString*)passWord;
- (void)LoginOut;
+ (id)shareInstance;

@end
