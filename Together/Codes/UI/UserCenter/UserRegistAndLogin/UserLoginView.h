//
//  UserLoginView.h
//  Together
//
//  Created by APPLE on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserRegistView.h"
#import "UserLoginRequest.h"
#import "TipViewManager.h"

@class UserLoginView;

@protocol UserLoginDelegate <NSObject>

- (void)userLoginViewDidRemove:(UserLoginView*)v;

@end

@interface UserLoginView : UIView<UITextFieldDelegate,NetUserRequestDelegate>
{
    __weak IBOutlet UITextField                  *_iUserNameFiled;
    __weak IBOutlet UITextField                  *_iPassWordTextFiled;
    __weak IBOutlet UIButton                     *_iSubMitBtn;
    __weak IBOutlet UILabel                      *_iUserNameTipInfo;
    __weak IBOutlet UILabel                      *_iPassWordTipInfo;
    __weak IBOutlet UIView                       *_iLoginView;
    __weak id<UserLoginDelegate>                 _delegate;
    
    UserRegistView                               *_iRegistView;
    BOOL                                         _isLogin;
}



@property (weak, nonatomic) id<UserLoginDelegate>   delegate;

- (IBAction)closeBtnDidPressed:(id)sender;
- (IBAction)registBtnDidPressed:(id)sender;
- (IBAction)submitBtnDidPressed:(id)sender;

@end
