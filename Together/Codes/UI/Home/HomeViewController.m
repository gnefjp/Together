//
//  HomeViewController.m
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "HomeViewController.h"

#import "NavigationView.h"
#import "RoomListView.h"
#import "UserCenterView.h"

#import "RoomViewController.h"

@implementation HomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mainView = [RoomListView loadFromNib];
    [self.view addSubview:_mainView];
    
    _navigationView = [NavigationView loadFromNib];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
    
    [self _isShowNavigation:NO animation:NO];
}


#pragma mark- 导航栏
- (void) _isShowNavigation:(BOOL)isShow animation:(BOOL)animation
{
    _navigationView.frameX = !isShow ? 0.0 : -242.0;
    _mainView.frameX = !isShow ? 242.0 : 0.0;
    
    if (animation)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
    }
    
    _navigationView.frameX = isShow ? 0.0 : -242.0;
    _mainView.frameX = isShow ? 242.0 : 0.0;
    
    if (animation)
    {
        [UIView commitAnimations];
    }
}


#pragma mark- NavigationViewDelegate
- (void) NavigationView:(NavigationView *)navigationView wantInModulWithType:(ModulType)modulType
{
    [_mainView removeFromSuperview];
    
    switch (modulType)
    {
        case ModulType_RoomList:
        {
            _mainView = [RoomListView loadFromNib];
            break;
        }
        case ModulType_UserCenter:
        {
            _mainView = [UserCenterView loadFromNib];
            break;
        }
        default:
            break;
    }
    
    
    [self.view insertSubview:_mainView belowSubview:_navigationView];
    [self _isShowNavigation:NO animation:YES];
}


- (void) NavigationViewShowBtnPressed:(NavigationView *)navigationView
{
    BOOL isShowingNavigation = (_navigationView.frameX > -1.0);
    
    [self _isShowNavigation:!isShowingNavigation animation:YES];
}

@end
