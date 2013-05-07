//
//  UserLoginView.m
//  Together
//
//  Created by APPLE on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserLoginView.h"

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
        _isLogin = YES;
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
    if (!_iRegistView)
    {
        _iRegistView = [UserRegistView loadFromNib];
        [self addSubview:_iRegistView];
        _iRegistView.center = CGPointMake(160*3,_iLoginView.center.y);
    }
    
    [UIView animateWithDuration:0.4 animations:^(void)
     {
         _iRegistView.center = CGPointMake(160,_iLoginView.center.y);
         _iLoginView.center = CGPointMake(-160,_iLoginView.center.y);
     }];

}

- (void)NetUserRequestSuccess:(NetUserRequest *)request
{
    NSLog(@"%@",request.responseData.loginResponse.userInfo.username);
}

- (void)NetUserRequestFail:(NetUserRequest *)request
{
    NSString *str;
    switch (request.responseData.code)
    {
        case LOGIN_SUCCESS:
            break;
        case USER_NOT_EXIST:
            str = @"注册失败";
            break;
        case LOGIN_REPLACE:
            str = @"用户已经存在";
            break;
        default :
            str = @"网络繁忙,请稍后在试";
            break;
    }
    
    [[TipViewManager defaultManager] showTipText:str
                                       imageName:nil
                                          inView:self
                                              ID:self];
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES delay:1];
}

- (IBAction)submitBtnDidPressed:(id)sender
{
    if ([self checkUserName]&&[self checkPassWord])
    {
        NSLog(@"submitMethod");
        NSLog(@"userName : %@, passWord  : %@", _iUserNameFiled.text, _iPassWordTextFiled.text);
        
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
        _iPassWordTipInfo.text = @"提示信息:帐号小于6个字符";
        return NO;
    }
    else if (_iPassWordTextFiled.text.length>15)
    {
        [_iPassWordTipInfo setHidden:NO];
        _iPassWordTipInfo.text = @"提示信息:帐号大于15个字符";
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
    switch (textField.tag) {
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
    [_delegate UserLoginViewDidRemove:self];
    [super removeFromSuperview];
}

@end
