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
   
    if ([_userInfo.userId isEqualToNumber:[GEMTUserManager defaultManager].userInfo.userId])
    {
        [_iEditBtn setHidden:NO];
        [_iZanBtn setEnabled:NO];
    }

    switch (_eType)
    {
        case followRelation_follow:
            NSLog(@"follow");
            break;
        case followRelation_unFollow:
             NSLog(@"unfollow");
            break;
        case followRelation_Own:
             NSLog(@"ownfollow");
            break;
        default:
            break;
    }
    
}

- (void)awakeFromNib
{
    
//    UserPersonInfoRequest *request = [[UserPersonInfoRequest alloc] init];
//    request.delegate = self;
//    request.aUid = [NSString stringWithFormat:@"%@",_userInfo.userId];
//    [[NetRequestManager defaultManager] startRequest:request];
}

- (void)NetUserRequestSuccess:(NetUserRequest *)request
{
    if ([request isKindOfClass:[UserPersonInfoRequest class]])
    {
        [[TipViewManager defaultManager] hideTipWithID:self
                                             animation:YES];
        if (!_userInfo)
        {
            self.userInfo = [[GEMTUserInfo alloc] init];
        }
        [_userInfo setUserInfoWithLoginResPonse:request.responseData.detailResponse.userInfo];
        if ([_userInfo.userId isEqualToNumber:[GEMTUserManager defaultManager].userInfo.userId])
        {
            _eType = followRelation_Own;
        }else
        {
            _eType = request.responseData.detailResponse.isFollow?followRelation_follow:followRelation_unFollow;
        }
        [self resetInfo];
    }
}

- (void)NetUserRequestFail:(NetUserRequest *)request
{
    [[TipViewManager defaultManager] showTipText:@"网络繁忙"
                                       imageName:@""
                                          inView:self
                                              ID:self];
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
}

- (void)changeUserInfo:(GEMTUserInfo*)aUserInfo
{
    self.userInfo = aUserInfo;
    [self resetInfo];
}

- (void)viewUserInfoWithUserId:(NSString*)aUserId
{
    [[TipViewManager defaultManager] showTipText:@"loading..."
                                       imageName:@""
                                          inView:self
                                              ID:self];
    
    UserPersonInfoRequest *request = [[UserPersonInfoRequest alloc] init];
    request.delegate = self;
    request.aUid = aUserId;
    [[NetRequestManager defaultManager] startRequest:request];
}

- (IBAction)closeBtnDidPressed:(id)sender
{
    self.center = CGPointMake(160,274);
    [UIView animateWithDuration:0.4 animations:^(void)
     {
         self.center = CGPointMake(160*3,274);
     }completion:^(BOOL isFinished)
     {
         [self removeFromSuperview];
     }];
}


- (IBAction)viewOtherInfo:(id)sender
{
    UserPersonInfoRequest *request = [[UserPersonInfoRequest alloc] init];
    request.delegate = self;
    request.aUid = @"1";
    [[NetRequestManager defaultManager] startRequest:request];
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
//    follow.followId = [NSString stringWithFormat:@"%@",_userInfo.userId];
    follow.followId =@"1";
    follow.delegate = self;
    [[NetRequestManager defaultManager] startRequest:follow];
}

- (IBAction)unfollow:(id)sender
{
    UserUnFollowRequest *request = [[UserUnFollowRequest alloc] init];
    request.delegate = self;
//    request.unFollowId = [NSString stringWithFormat:@"%@",_userInfo.userId];
     request.unFollowId = @"1";
    [[NetRequestManager defaultManager] startRequest:request];
}

- (IBAction)pariseOthers:(id)sender
{
    UserZanRequest *request = [[UserZanRequest alloc] init];
    request.delegate = self;
    [[NetRequestManager defaultManager] startRequest:request];
}


- (IBAction)showFollowListBtnDidPressed:(id)sender
{
    UserFriendView *frinedView = [UserFriendView loadFromNib];
    [frinedView initWithFolloUserId:[NSString stringWithFormat:@"%@",_userInfo.userId]];
    [frinedView showRightToCenterAnimation];
    [self addSubview:frinedView];
    
    frinedView.center = CGPointMake(160*3,274);
    [UIView animateWithDuration:0.4 animations:^(void)
     {
         frinedView.center = CGPointMake(160,274);
     }];
}

- (IBAction)showFanListBtnDidPressed:(id)sender
{
    UserFriendView *frinedView = [UserFriendView loadFromNib];
    [frinedView initWithFanSUserId:[NSString stringWithFormat:@"%@",_userInfo.userId]];
    [frinedView showRightToCenterAnimation];
    [self addSubview:frinedView];
    
    frinedView.center = CGPointMake(160*3,274);
    [UIView animateWithDuration:0.4 animations:^(void)
     {
         frinedView.center = CGPointMake(160,274);
     }];

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
    [[GEMTUserManager defaultManager] shouldAddLoginViewToTopView];
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
