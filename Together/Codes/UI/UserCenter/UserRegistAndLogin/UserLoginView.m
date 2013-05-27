//
//  UserLoginView.m
//  Together
//
//  Created by APPLE on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserLoginView.h"
#import "GEMTUserManager.h"
#import "KeepSorcket.h"

@implementation UserLoginView
@synthesize delegate = _delegate;

- (void)awakeFromNib
{
    _iUserNameFiled.delegate = self;
    _iPassWordTextFiled.delegate = self;
    [_iUserNameFiled becomeFirstResponder];
    _isLogin = YES;
    [_iPassWordTextFiled setSecureTextEntry:YES];
}

- (IBAction)closeBtnDidPressed:(id)sender
{
    if (_isLogin) {
        [self hideCenterToRightAnimation];
    }else
    {
        _iTiTleLb.text = @"登陆"; 
        _isLogin = YES;
        [_iRegistBtn setHidden:NO];
        [UIView animateWithDuration:0.4 animations:^(void)
        {
            _iRegistView.center = CGPointMake(160*3,_iLoginView.center.y);
            _iLoginView.center = CGPointMake(160,_iLoginView.center.y);
            
        }];
    }
}

- (IBAction)registBtnDidPressed:(id)sender
{
    _isLogin = NO;
    _iTiTleLb.text = @"注册";
    [_iRegistBtn setHidden:YES];
    
    if (!_iRegistView)
    {
        _iRegistView = [UserRegistView loadFromNib];
        [self addSubview:_iRegistView];
        _iRegistView.delegate =self;
        _iRegistView.center = CGPointMake(160*3,_iLoginView.center.y);
    }
    [_iRegistView resetInfo];
    [UIView animateWithDuration:0.4 animations:^(void)
     {
         _iRegistView.center = CGPointMake(160,_iLoginView.center.y);
         _iLoginView.center = CGPointMake(-160,_iLoginView.center.y);
     }];

}

- (void)UserRegistViewBack:(UserRegistView *)v userName:(NSString *)aUserName
{
    _iUserNameFiled.text = aUserName;
    [self checkUserName];
    [_iPassWordTextFiled becomeFirstResponder];
    [self closeBtnDidPressed:nil];
}
- (void)NetUserRequestSuccess:(NetUserRequest *)request
{
    [[[GEMTUserManager defaultManager] userInfo] setUserInfoWithLoginResPonse:request.responseData.loginResponse.userInfo];
    
    [[GEMTUserManager defaultManager] userName:request.responseData.loginResponse.userInfo.username
                                     passWord:_iPassWordTextFiled.text
                                          sid:request.responseData.loginResponse.sid];
    
    [[GEMTUserManager defaultManager] userInfoWirteToFile];
    
    [[TipViewManager defaultManager] showTipText:@"请求成功"
                                       imageName:kCommonImage_SuccessIcon
                                          inView:self
                                              ID:self];
    [[TipViewManager defaultManager] hideTipWithID:self
                                         animation:YES
                                             delay:1];
    [[KeepSorcket defaultManager] connectToHost];
    [self closeBtnDidPressed:nil];
}

- (void)NetUserRequestFail:(NetUserRequest *)request
{
    NSString *str;
    switch (request.responseData.code)
    {
        case USER_NOT_EXIST:
            str = @"用户名或密码错误";
            break;
        default :
            str = @"网络繁忙,请稍后在试";
            break;
    }
    
    [[TipViewManager defaultManager] showTipText:str
                                       imageName:kCommonImage_FailIcon
                                          inView:self
                                              ID:self];
    [[TipViewManager defaultManager] hideTipWithID:self
                                         animation:YES
                                             delay:1];
}

- (IBAction)submitBtnDidPressed:(id)sender
{    
    if ([self checkUserName]&&[self checkPassWord])
    {
        
        [[TipViewManager defaultManager] showTipText:@"loading..."
                                           imageName:nil
                                              inView:self
                                                  ID:self];

        UserLoginRequest *request = [[UserLoginRequest alloc] init];
        request.userName = _iUserNameFiled.text;
        request.delegate = self;
        request.password = _iPassWordTextFiled.text;
        request.divToken = @"token";
        [[NetRequestManager defaultManager] startRequest:request];
    }
}



- (BOOL)checkUserName
{
    if (_iUserNameFiled.text.length<6)
    {
        [_iUserNameTipInfo setHidden:NO];
        _iUserNameTipInfo.text = @"提示信息:帐号小于6个字符";
        return NO;
    }
    else if (_iUserNameFiled.text.length>15)
    {
        [_iUserNameTipInfo setHidden:NO];
        _iUserNameTipInfo.text = @"提示信息:帐号大于15个字符";
        return NO;
    }
    else
    {
        NSString *str = @"[a-zA-Z0-9]{5,15}$";
        [_iUserNameTipInfo setHidden:NO];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:str options:0 error:nil];
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:_iUserNameFiled.text options:0 range:NSMakeRange(0, [_iUserNameFiled.text length])];
        if (!firstMatch) {
            _iUserNameTipInfo.text = @"提示信息:含有非法字符";
            return NO;
        }else
        {
            [_iUserNameTipInfo setHidden:YES];
            return YES;
        }
    }
}

- (BOOL)checkPassWord
{
    if (_iPassWordTextFiled.text.length<6)
    {
        [_iPassWordTipInfo setHidden:NO];
        _iPassWordTipInfo.text = @"提示信息:密码小于6个字符";
        return NO;
    }
    else if (_iPassWordTextFiled.text.length>15)
    {
        [_iPassWordTipInfo setHidden:NO];
        _iPassWordTipInfo.text = @"提示信息:密码大于15个字符";
        return NO;
    }
    else
    {
        NSString *str = @"[a-zA-Z0-9]{5,15}$";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:str options:0 error:nil];
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:_iPassWordTextFiled.text options:0 range:NSMakeRange(0, [_iPassWordTextFiled.text length])];
        if (!firstMatch) {
            _iPassWordTipInfo.text = @"提示信息:含有非法字符";
            return NO;
        }else
        {
            [_iPassWordTipInfo setHidden:YES];
            return YES;
        }
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag)
    {
        case 1000:
        {
            [self checkUserName];
            break;
        }
        case 1001:
        {
            [self checkPassWord];
            break;
        }
        default:
            break;
    }
}

- (void)removeFromSuperview
{
    [_delegate userLoginViewDidRemove:self];
    [super removeFromSuperview];
}

@end
