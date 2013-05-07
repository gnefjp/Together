//
//  GEMTUserManager.m
//  Together
//
//  Created by APPLE on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GEMTUserManager.h"
#import "TipViewManager.h"

static GEMTUserManager *instance;
@implementation GEMTUserManager

@synthesize userInfo = _userInfo;
@synthesize isLogIn  = _isLogIn;

+ (id)shareInstance
{
    if (!instance)
    {
        instance = [[GEMTUserManager alloc] init];
    }
    return instance;
}

- (GEMTUserInfo*)getUserInfo
{
    if (!_userInfo)
    {
        _userInfo = [[GEMTUserInfo alloc] init];
    }
    return _userInfo;
}

- (NSString*)_userName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:@"aUserName"];
}

- (NSString*)_passWord
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:@"aUserPassWord"];
}


- (void)userName:(NSString*)aUserName passWord:(NSString*)aPassWord
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:_userInfo.userName forKey:@"aUserName"];
    [defaults setValue:_userInfo.passWord forKey:@"aUserPassWord"];
    [defaults synchronize];
}

- (void)_removeuserNameAndPassWord
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"aUserName"];
    [defaults removeObjectForKey:@"aUserPassWord"];
    [defaults synchronize];
}

- (BOOL)shouldAddLoginViewToTopView
{
    @synchronized(self)
    {
//        if (_isLogIn)
//        {
//            return NO;
//        }
        if (_isLoginIng)
        {
            [[TipViewManager defaultManager] showTipText:@"正在登陆，请稍候"
                                               imageName:@""
                                                  inView:[UIView rootView]
                                                      ID:self];
            [[TipViewManager defaultManager] hideTipWithID:self animation:YES delay:0.4];
            return NO;
        }
        if (!_isShowLoginView)
        {
            _isShowLoginView = YES;
            UserLoginView *loginView =  [UserLoginView loadFromNib];
            [[UIView rootView] addSubview:loginView];
            loginView.delegate = self;
            [loginView showRightToCenterAnimation];
            return YES;
        }
        return NO;
    }
}

- (void)userLoginViewDidRemove:(UserLoginView *)v
{
    _isShowLoginView = NO;
}

- (void)autoLogin
{
    if ([self _userName]&&[self _passWord]&&!_isLoginIng&&!_isLogIn)
    {
        _isLoginIng = YES;
        UserLoginRequest *request = [[UserLoginRequest alloc] init];
        request.userName = [self _userName];
        request.delegate = self;
        request.password = [self _passWord];
        request.divToken = @"token";
    }
}

- (void)NetUserRequestSuccess:(NetUserRequest *)request
{
    _isLogIn = YES;
    _isLoginIng = NO;
    [[self getUserInfo] setUserInfoWithLoginResPonse:request.responseData.loginResponse.userInfo];
}

- (void)NetUserRequestFail:(NetUserRequest *)request
{
    _isLogIn = NO;
    _isLoginIng = NO;
    [self _removeuserNameAndPassWord];
}

- (void)LogInWithUserName:(NSString*)userName
                 passWord:(NSString*)passWord
{
    
}

- (void)LoginOut
{
    
}
@end
