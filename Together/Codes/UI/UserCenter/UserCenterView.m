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
#import "UserZanRequest.h"
#import "UserFriendView.h"
#import "UserUnFollowRequest.h"

@implementation UserCenterView
@synthesize userInfo = _userInfo;

- (void) resetInfo
{
    _iNickName.text = _userInfo.nickName;
    _iAgeLb.text = [NSString stringWithFormat:@"%@岁",_userInfo.age];
    _iSexLb.text = [_userInfo.sex intValue]?@"男":@"女";
    _iPraiseLb.text = [NSString stringWithFormat:@"%@",_userInfo.praiseNum];
    _iSignLb.text = [NSString stringWithFormat:@"个性签名 ：%@",_userInfo.signatureText];
    if ([_userInfo.userId isEqualToNumber:[[GEMTUserManager shareInstance] getUserInfo].userId])
    {
        [_iEditBtn setHidden:NO];
        [_iZanBtn setEnabled:NO];
    }
}

- (void)awakeFromNib
{
    
}

- (void)NetUserRequestSuccess:(NetUserRequest *)request
{
    NSLog(@"%@",request.responseData.loginResponse.userInfo.nickName);
}

- (void)NetUserRequestFail:(NetUserRequest *)request
{
    NSLog(@"%@",request.actionCode);
}

- (void)changeUserInfo:(GEMTUserInfo*)aUserInfo
{
    self.userInfo = aUserInfo;
    [self resetInfo];
}



- (IBAction)viewOtherInfo:(id)sender
{
//    if (![[GEMTUserManager shareInstance] shouldAddLoginViewToTopView]) {
        UserPersonInfoRequest *request = [[UserPersonInfoRequest alloc] init];
        request.delegate = self;
        request.aUid = @"1";
        [[NetRequestManager defaultManager] startRequest:request];
//    }
}

- (IBAction)modifyInfo:(id)sender
{
    UserInfoModifyRequest *request = [[UserInfoModifyRequest alloc] init];
    request.delegate = self;
    [[NetRequestManager defaultManager] startRequest:request];
}

- (IBAction)followOther:(id)sender
{
    UserFollowRequest *follow = [[UserFollowRequest alloc] init];
    follow.delegate = self;
    [[NetRequestManager defaultManager] startRequest:follow];
    
}

- (IBAction)pariseOthers:(id)sender
{
    UserZanRequest *request = [[UserZanRequest alloc] init];
    request.delegate = self;
    [[NetRequestManager defaultManager] startRequest:request];
}

- (IBAction)unfollow:(id)sender
{
    UserUnFollowRequest *request = [[UserUnFollowRequest alloc] init];
    request.delegate = self;
    [[NetRequestManager defaultManager] startRequest:request];
}

- (IBAction)showFollowListBtnDidPressed:(id)sender
{
    UserFriendView *frinedView = [UserFriendView loadFromNib];
    [frinedView showRightToCenterAnimation];
    [self addSubview:frinedView];
}

- (IBAction)showFanListBtnDidPressed:(id)sender
{
    UserFriendView *frinedView = [UserFriendView loadFromNib];
    [self addSubview:frinedView];
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
    editInfo.delegate = self;
    [[UIView rootController] pushViewController:editInfo animated:YES];
}

- (void)UserEditDidSuccess:(UserEditUserInfoView *)v
{
    [self resetInfo];
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
