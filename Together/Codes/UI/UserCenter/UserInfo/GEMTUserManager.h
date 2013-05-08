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
    NSString            *_sId;
}

@property (strong , nonatomic) GEMTUserInfo        *userInfo;
@property (strong , nonatomic) NSString            *sId;

- (GEMTUserInfo*)getUserInfo;
- (void)userName:(NSString*)aUserName passWord:(NSString*)aPassWord sid:(NSString*)aId;

- (BOOL)shouldAddLoginViewToTopView;
- (void)removeuserNameAndPassWord;

- (NSString*)sId;
//- (void)autoLogin;
- (void)LogInWithUserName:(NSString*)userName
                 passWord:(NSString*)passWord;
- (void)LoginOut;
+ (id)shareInstance;

@end
