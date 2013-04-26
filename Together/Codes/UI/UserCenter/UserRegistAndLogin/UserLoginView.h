//
//  UserLoginView.h
//  Together
//
//  Created by APPLE on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserLoginView;

@protocol UserLoginViewDelegate <NSObject>

- (void)UserLoginViewDidRemove:(UserLoginView*)v;

@end

@interface UserLoginView : UIView
{
   __weak id<UserLoginViewDelegate>           _delegate;
}

@property (weak, nonatomic) id<UserLoginViewDelegate>   delegate;

@end
