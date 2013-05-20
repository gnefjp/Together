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
@synthesize sId = _sId;

+ (GEMTUserManager*)defaultManager
{
    
    @synchronized(self)
    {
        if (!instance)
        {
         instance = [[GEMTUserManager alloc] init];
        }
    }
    return instance;
}



- (NSString*)sId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _sId = [defaults valueForKey:@"aSid"];
    return _sId;
}

- (NSString*) _getUserFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/userInfo.plist",documentsDirectory];
    return filePath;
}

- (GEMTUserInfo*)userInfo
{
    if (!_userInfo)
    {
        NSString *filePath = [self _getUserFilePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:
             filePath])
        {
            _userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        }
        else
        {
            _userInfo = [[GEMTUserInfo alloc] init];
        }
    }
    return _userInfo;
}

- (void)userInfoWirteToFile
{
    if (self.userInfo) {
        NSString *filePath = [self _getUserFilePath];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.userInfo];
        [data writeToFile:filePath atomically:YES];
    }
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


- (void)userName:(NSString*)aUserName
        passWord:(NSString*)aPassWord
             sid:(NSString*)aId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:aUserName forKey:@"aUserName"];
    [defaults setValue:aPassWord forKey:@"aUserPassWord"];
    [defaults setValue:aId forKey:@"aSid"];
    [defaults synchronize];
}

- (void)removeuserNameAndPassWord
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"aUserName"];
    [defaults removeObjectForKey:@"aUserPassWord"];
    [defaults removeObjectForKey:@"aSid"];
    [defaults synchronize];
}

- (BOOL) _isLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sid = [defaults valueForKey:@"aSid"];
    return sid?YES:NO;
}

- (BOOL)shouldAddLoginViewToTopView
{
    @synchronized(self)
    {
        if ([self _isLogin]) {
            return NO;
        }
        
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
}

- (void)NetUserRequestSuccess:(NetUserRequest *)request
{
    [[TipViewManager defaultManager] showTipText:@"登陆成功"
                                       imageName:@""
                                          inView:[UIView rootView]
                                              ID:self];
    [[TipViewManager defaultManager] hideTipWithID:self
                                         animation:YES];
    UserLoginRequest *tRequest = (UserLoginRequest*)request;
    
    [self.userInfo setUserInfoWithLoginResPonse:tRequest.responseData.loginResponse.userInfo];
    
    [self userName:tRequest.userName
          passWord:tRequest.password
               sid:tRequest.responseData.loginResponse.sid
                ];
    [self userInfoWirteToFile];
}

- (void)NetUserRequestFail:(NetUserRequest *)request
{
    
}

- (void)LogInWithUserName:(NSString*)userName
                 passWord:(NSString*)passWord
{
    [[TipViewManager defaultManager] showTipText:@"正在登录"
                                       imageName:@""
                                          inView:[UIView rootView]
                                              ID:self];
    
    UserLoginRequest *request = [[UserLoginRequest alloc] init];
    request.userName = userName;
    request.delegate = self;
    request.password = passWord;
    request.divToken = @"token";
}

- (void)LoginOut
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"aSid"];
    
    [GEMTUserManager defaultManager].sId = nil;
    [[NSFileManager defaultManager] removeItemAtPath:[self _getUserFilePath] error:nil];
    [GEMTUserManager defaultManager].userInfo = nil;
}
@end
