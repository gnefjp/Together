//
//  UserCenterView.m
//  Together
//
//  Created by APPLE on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserCenterView.h"
#import "GMETRecorder.h"
#import "GEMTUserManager.h"
#import "UserEditUserInfoView.h"
#import "UserPersonInfoRequest.h"
#import "UserInfoModifyRequest.h"

@implementation UserCenterView

- (void)NetUserRequestSuccess:(NetUserRequest *)request
{
    NSLog(@"%@",request.responseData.loginResponse.userInfo.nickName);
}

- (void)NetUserRequestFail:(NetUserRequest *)request
{
    
}

- (IBAction)viewOtherInfo:(id)sender
{
    UserPersonInfoRequest *request = [[UserPersonInfoRequest alloc] init];
    request.delegate = self;
    [[NetRequestManager defaultManager] startRequest:request];
    
}

- (IBAction)modifyInfo:(id)sender
{
    UserInfoModifyRequest *request = [[UserInfoModifyRequest alloc] init];
    request.delegate = self;
    [[NetRequestManager defaultManager] startRequest:request];
}

- (IBAction)showMapViewBtnDidpressed:(id)sender
{
    MapView *mapView = [MapView loadFromNib];
    [[UIView rootView] addSubview:mapView];
    [mapView showRightToCenterAnimation];
    mapView.delegate = self;
}

- (void)MapView:(MapView *)view location:(CLLocationCoordinate2D)aLocation
{
    NSLog(@"%lf,%lf",aLocation.latitude,aLocation.longitude);
}

- (void)PicChangeSuccess:(PicChange *)self img:(UIImage *)img
{
    _iAvatarImage.image = img;
}


- (IBAction)recordBtnDidPressed:(id)sender
{
    if (!_recorder)
    {
        _recorder = [GMETRecorder startRecordWithTime:30];
    }
    [_recorder start];
}

- (IBAction)stopRecordBtnDidPressed:(id)sender
{
    [_recorder stop];
}

- (IBAction)changeAvataBtnDidPressed:(id)sender
{
    if (!_avatar)
    {
        _avatar = [[PicChange alloc] init];
        _avatar.delegate = self;
    }
    [_avatar addAvataActionSheet];
}

- (IBAction)loginBtnDidPressed:(id)sender
{
    [[GEMTUserManager shareInstance] shouldAddLoginViewToTopView];
}

- (IBAction)editInfoBtnDidPressed:(id)sender
{
    UserEditUserInfoView *editInfo = [UserEditUserInfoView loadFromNib];
    [[UIView rootController] pushViewController:editInfo animated:YES];
}

- (IBAction)_playBtnDidPressed:(id)sender
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryAmbient error:nil];
    [session setActive:YES error:nil];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:
                                   [GMETRecorder getRecordFileUrl] error:nil];
    [_player prepareToPlay];
    [_player play];
}



@end
