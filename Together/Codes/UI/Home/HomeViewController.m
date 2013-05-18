//
//  HomeViewController.m
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GMETTapView.h"

#import "AppSetting.h"

#import "HomeViewController.h"

#import "NavigationView.h"
#import "RoomListView.h"
#import "UserCenterView.h"

#import "RoomViewController.h"
#import "GEMTUserManager.h"

#define kPanWidth       10

@implementation HomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _getCurrentLocation];
    
    _navigationView = [NavigationView loadFromNib];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
    
    _mainView = [RoomListView loadFromNib];
    ((RoomListView *)_mainView).delegate = self;
    [self.view addSubview:_mainView];
    [self _initPanGesture];
    
    [self _isShowNavigation:NO animation:NO];
}


#pragma mark- 定位
- (void) _getCurrentLocation
{
    _locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled])
    {
        _locationManager.delegate = self;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager startUpdatingLocation];
    }
    else
    {
        [self _setLocationServe];
    }
}


#pragma mark- CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    [AppSetting defaultSetting].currentLocation = newLocation;
    
    if (oldLocation == nil && newLocation != nil)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_InitCurrentLocation
                                                            object:nil];
    }
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [self _setLocationServe];
}

#pragma mark- 设置定位服务
- (void) _setLocationServe
{
    NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
    
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请打开“定位服务”确定您的位置"
                                                            message:@"如果不使用定位服务\n"
                                                                    "将无法获取房间信息\n"
                                                                    "请点击“设置”进行设置"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"设置", nil];
        [alertView show];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请打开“定位服务”确定您的位置"
                                                            message:@"请到 设置 - 隐私 - 定位服务 中 \n"
                                                                    "打开定位服务功能\n"
                                                                    "并允许“Together”访问此功能"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}


#pragma mark- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSURL*url=[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
        [[UIApplication sharedApplication] openURL:url];
    }
}


- (void)alertViewCancel:(UIAlertView *)alertView
{
    // TODO: 取消定位服务
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
    if (isShow == (_mainView.frameX > 10.0))
    {
        return;
    }
    
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
    if (panGesture.state == UIGestureRecognizerStateEnded)
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


#pragma mark- RoomListViewDelegate
- (void) RoomListViewShowNavigation:(RoomListView *)roomListView
{
    [self _isShowNavigation:YES animation:YES];
}



#pragma mark- NavigationViewDelegate
- (void) NavigationView:(NavigationView *)navigationView wantInModulWithType:(ModulType)modulType
{
    switch (modulType)
    {
        case ModulType_RoomList:
        {
            [_mainView removeFromSuperview];
            _mainView = [RoomListView loadFromNib];
            ((RoomListView *)_mainView).delegate = self;
            break;
        }
        case ModulType_UserCenter:
        {
            if (![[GEMTUserManager defaultManager] shouldAddLoginViewToTopView]) {
                [_mainView removeFromSuperview];
                UserCenterView *tmpView = [UserCenterView loadFromNib];
                [tmpView viewUserInfoWithUserId:[NSString stringWithFormat:@"%@",[GEMTUserManager defaultManager].userInfo.userId]];
                [tmpView setHasBack:YES];
                tmpView.panGesture = _panGesture;
                _mainView = tmpView;
            }
            break;
        }
        default:
            break;
    }
    
    [self _initPanGesture];
    [self.view addSubview:_mainView];
    _mainView.frameX = 268.0;
    [self _isShowNavigation:NO animation:YES];
}

@end
