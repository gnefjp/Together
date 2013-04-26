//
//  HomeViewController.m
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GMETTapView.h"

#import "HomeViewController.h"

#import "NavigationView.h"
#import "RoomListView.h"
#import "UserCenterView.h"

#import "RoomViewController.h"

#define kPanWidth       10

@implementation HomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _navigationView = [NavigationView loadFromNib];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
    
    _mainView = [RoomListView loadFromNib];
    [self.view addSubview:_mainView];
    [self _initPanGesture];
    
    [self _isShowNavigation:NO animation:NO];
}


#pragma mark- TapView
- (void) _initTapView
{
    [_tapView removeFromSuperview];
    _tapView = [[GMETTapView alloc] initWithFrame:_mainView.bounds];
    _tapView.delegate = self;
    _tapView.backgroundColor = [UIColor clearColor];
    _tapView.alpha = 1.0f;
    [_mainView addSubview:_tapView];
}


#pragma mark- GMETTapViewDelegate
- (void) GMETTapView:(GMETTapView *)tapView touchEnded:(UIEvent *)event
{
    [self _isShowNavigation:NO animation:YES];
}


#pragma mark- 导航栏
- (void) _isShowNavigation:(BOOL)isShow animation:(BOOL)animation
{
    _mainView.frameX = !isShow ? 268.0 : 0.0;
    
    if (isShow)
    {
        [self _initTapView];
    }
    else
    {
        [_tapView removeFromSuperview];
        _tapView = nil;
    }
    
    if (animation)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
    }
    
    _mainView.frameX = isShow ? 268.0 : 0.0;
    
    if (animation)
    {
        [UIView commitAnimations];
    }
}


#pragma mark- 导航手势
- (void) _initPanGesture
{
    [_mainView removeGestureRecognizer:_panGesture];
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(_handlePan:)];
    [_mainView addGestureRecognizer:_panGesture];
}


- (void) _handlePan:(UIPanGestureRecognizer *)panGesture
{
    if (panGesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint offset = [panGesture translationInView:_mainView];
        
        if (offset.x > kPanWidth)
        {
            [self _isShowNavigation:YES animation:YES];
        }
        else if (offset.x < -kPanWidth)
        {
            [self _isShowNavigation:NO animation:YES];
        }
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
    
    [self _initPanGesture];
    [self.view addSubview:_mainView];
    [self _isShowNavigation:NO animation:YES];
}

@end
