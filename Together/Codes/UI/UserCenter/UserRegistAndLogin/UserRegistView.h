//
//  UserRegistView.h
//  Together
//
//  Created by APPLE on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserRegisterRequest.h"

@class UserRegistView;
@class TipViewManager;

@protocol UserRegistViewDelegate <NSObject>

- (void)UserRegistViewBack:(UserRegistView*)v;

@end

@interface UserRegistView : UIView<UITextFieldDelegate, NetUserRequestDelegate>
{
    __weak IBOutlet UITextField             *_iUserName;
    __weak IBOutlet UITextField             *_iPassWord;
    __weak IBOutlet UITextField             *_iRePassWord;
    
    __weak IBOutlet UILabel                 *_iUserNameTipsInfo;
    __weak IBOutlet UILabel                 *_iPassWordTipsInfo;
    __weak IBOutlet UILabel                 *_iRePassWordTipsInfo;
    __weak id<UserRegistViewDelegate>       _delegate;
}

@property (weak , nonatomic)  __weak id<UserRegistViewDelegate>   delegate;


- (IBAction)submitBtnDidPressedInfo:(id)sender;

@end
