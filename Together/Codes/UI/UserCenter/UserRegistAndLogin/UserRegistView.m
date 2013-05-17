//
//  UserRegistView.m
//  Together
//
//  Created by APPLE on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserRegistView.h"
#import "GEMTUserManager.h"
#import "TipViewManager.h"

@implementation UserRegistView
@synthesize delegate = _delegate;

- (void)awakeFromNib
{
    _iPassWord.delegate = self;
    _iUserName.delegate = self;
    _iRePassWord.delegate = self;
    
    [_iPassWord setSecureTextEntry:YES];
    [_iRePassWord setSecureTextEntry:YES];
    [_iUserName becomeFirstResponder];
}

- (BOOL)checkUserName
{
    if (_iUserName.text.length<6)
    {
        [_iUserNameTipsInfo setHidden:NO];
        _iUserNameTipsInfo.text = @"提示信息:帐号小于6个字符";
        return NO;
    }
    else if (_iUserName.text.length>15)
    {
        [_iUserNameTipsInfo setHidden:NO];
        _iUserNameTipsInfo.text = @"提示信息:帐号大于15个字符";
        return NO;
    }
    else
    {
        [_iUserNameTipsInfo setHidden:NO];
        NSString *str = @"[a-zA-Z0-9]{5,15}$";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:str options:0 error:nil];
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:_iUserName.text options:0 range:NSMakeRange(0, [_iUserName.text length])];
        if (!firstMatch) {
            _iUserNameTipsInfo.text = @"提示信息:含有非法字符";
            return NO;
        }else
        {
            [_iUserNameTipsInfo setHidden:YES];
            return YES;
        }
    }
}

- (BOOL)checkPassWord
{
    if (_iPassWord.text.length<6)
    {
        [_iPassWordTipsInfo setHidden:NO];
        _iPassWordTipsInfo.text = @"提示信息:密码小于6个字符";
        return NO;
    }
    else if (_iPassWord.text.length>15)
    {
        [_iPassWordTipsInfo setHidden:NO];
        _iPassWordTipsInfo.text = @"提示信息:密码大于15个字符";
        return NO;
    }
    else
    {
        NSString *str = @"[a-zA-Z0-9]{5,15}$";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:str options:0 error:nil];
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:_iPassWord.text options:0 range:NSMakeRange(0, [_iPassWord.text length])];
        if (!firstMatch)
        {
            _iPassWordTipsInfo.text = @"提示信息:含有非法字符";
            return NO;
        }else
        {
            [_iPassWordTipsInfo setHidden:YES];
            return YES;
        }
    }
}

- (BOOL)checkRePassWord
{
    if (_iRePassWord.text.length<6)
    {
        [_iRePassWordTipsInfo setHidden:NO];
        _iRePassWordTipsInfo.text = @"提示信息:密码小于6个字符";
        return NO;
    }
    else if (_iRePassWord.text.length>15)
    {
        [_iRePassWordTipsInfo setHidden:NO];
        _iRePassWordTipsInfo.text = @"提示信息:密码大于15个字符";
        return NO;
    }
    else if (![_iRePassWord.text isEqualToString:_iPassWord.text])
    {
         [_iRePassWordTipsInfo setHidden:NO];
        _iRePassWordTipsInfo.text = @"提示信息: 两次密码错误";
        return NO;
    }
    else
    {
        NSString *str = @"[a-zA-Z0-9]{5,15}$";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:str options:0 error:nil];
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:_iRePassWord.text options:0 range:NSMakeRange(0, [_iRePassWord.text length])];
        if (!firstMatch) {
            _iRePassWordTipsInfo.text = @"提示信息:含有非法字符";
            return NO;
        }else
        {
            [_iRePassWordTipsInfo setHidden:YES];
            return YES;
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag)
    {
        case 2000:
        {
            [self checkUserName];
            break;
        }
        case 2001:
        {
            [self checkPassWord];
            break;
        }
        case 2002:
        {
            [self checkRePassWord];
            break;
        }
        default:
            break;
    }
}

- (void)NetUserRequestSuccess:(NetUserRequest *)request
{
    [[TipViewManager defaultManager] showTipText:@"注册成功"
                                       imageName:kCommonImage_SuccessIcon
                                          inView:self
                                              ID:self];
    
    [[TipViewManager defaultManager] hideTipWithID:self
                                         animation:YES];
    [_delegate UserRegistViewBack:self];
}

- (void)NetUserRequestFail:(NetUserRequest *)request
{
    NSString *str;
    switch (request.responseData.code)
    {
        case REGIEST_SUCCESS:
            break;
        case REGIEST_FAIL:
            str = @"注册失败";
            break;
        case USERNAME_IS_EXIST:
            str = @"用户已经存在";
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

- (IBAction)submitBtnDidPressedInfo:(id)sender
{
    if ([self checkUserName]&&[self checkPassWord]&&[self checkRePassWord])
    {
        [[TipViewManager defaultManager] showTipText:@"loading..."
                                           imageName:nil
                                              inView:self
                                                  ID:self];
        UserRegisterRequest  *request = [[UserRegisterRequest alloc] init];
        request.delegate = self;
        request.userName = _iUserName.text;
        request.password = _iPassWord.text;
        [[NetRequestManager defaultManager] startRequest:request];
    }
}
@end
