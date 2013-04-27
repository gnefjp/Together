//
//  GEMTUserManager.m
//  Together
//
//  Created by APPLE on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GEMTUserManager.h"

static GEMTUserManager *instance;
@implementation GEMTUserManager

+ (id)shareInstance
{
    if (!instance) {
        instance = [[GEMTUserManager alloc] init];
    }
    return instance;
}

- (void)addLoginViewToTopView
{
    @synchronized(self)
    {
        if (!_isShowLoginView)
        {
            _isShowLoginView = YES;
            UserLoginView *loginView =  [UserLoginView loadFromNib];
            [[UIView rootView] addSubview:loginView];
            loginView.delegate = self;
            [loginView showRightToCenterAnimation];
        }
    }
}

- (void)UserLoginViewDidRemove:(UserLoginView *)v
{
    _isShowLoginView = NO;
}

- (void)autoLogin
{
    
}

- (void)LogInWithUserName:(NSString*)userName
                 passWord:(NSString*)passWord
{
    
}

- (void)LoginOut
{
    
}
@end
