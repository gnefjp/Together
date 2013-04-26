//
//  GEMTUserManager.h
//  Together
//
//  Created by APPLE on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserConfig.h"
#import "UserLoginView.h"
#import "UserLoginView.h"

@interface GEMTUserManager : NSObject<UserLoginViewDelegate>
{
    BOOL                _isShowLoginView;
}

- (void)addLoginViewToTopView;
- (void)autoLogin;
- (void)LogInWithUserName:(NSString*)userName
                 passWord:(NSString*)passWord;
- (void)LoginOut;
+ (id)shareInstance;

@end
