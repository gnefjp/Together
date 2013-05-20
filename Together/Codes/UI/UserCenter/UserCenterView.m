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
#import "PicCutView.h"
#import "RecorderView.h"
#import "CommonTool.h"
#import "NetFileManager.h"

#import "ChatViewController.h"

@implementation UserCenterView
@synthesize userInfo = _userInfo;
@synthesize panGesture = _panGesture;
@synthesize hasBack = _hasBack;


- (void) resetInfo
{
    _iNickName.text = _userInfo.nickName;
    _iAgeLb.text = [NSString stringWithFormat:@"%@岁",_userInfo.age];
    _iSexLb.text = _userInfo.eGenderType?@"男":@"女";
    _iPraiseLb.text = _userInfo.praiseNum;
    _iSignLb.text = [NSString stringWithFormat:@"个性签名 ：%@",_userInfo.signatureText];
    _iFollowLb.text = _userInfo.followNum;
    _iFansLb.text = _userInfo.followedNum;
    
    [_iAvatarImage setImageWithFileID:_userInfo.avataId placeholderImage:[UIImage imageNamed:kDefaultUserAvatar]];
    
    if ([_userInfo.userId isEqualToString:[GEMTUserManager defaultManager].userInfo.userId])
    {
        [_iEditBtn setHidden:NO];
        [_iZanBtn setEnabled:NO];
        [_followBtn setHidden:YES];
        [_sendMsgBtn setTitle:@"注销" forState:UIControlStateNormal];
        [_sendMsgBtn setTitle:@"注销" forState:UIControlStateNormal];
    }else
    {
        [_iEditBtn setHidden:YES];
        [_iZanBtn setEnabled:YES];
        [_followBtn setHidden:NO];
        [_sendMsgBtn setTitle:@"发消息" forState:UIControlStateNormal];
        [_sendMsgBtn setTitle:@"发消息" forState:UIControlStateHighlighted];
    }

    switch (_eType)
    {
        case followRelation_follow:
            [_followBtn setTitle:@"取消关注" forState:UIControlStateNormal];
            [_followBtn setTitle:@"取消关注" forState:UIControlStateHighlighted];
            break;
        case followRelation_unFollow:
            [_followBtn setTitle:@"加关注" forState:UIControlStateNormal];
            [_followBtn setTitle:@"加关注" forState:UIControlStateHighlighted];
    
            break;
        case followRelation_Own:
            break;
        default:
            break;
    }
}

- (IBAction)playVoicebtnDidPressed:(id)sender
{
    [[NetFileManager defaultManager] fileWithID:_userInfo.signatureRecordId delegate:self];
}

- (void) NetFileManager:(NetFileManager *)fileManager fileID:(NSString *)fileID fileData:(NSData *)fileData
{
    _player = [[AVAudioPlayer alloc] initWithData:fileData error:nil];
    [_player prepareToPlay];
    [_player play];
}

- (void)setHasBack:(BOOL)hasBack
{
    if (hasBack)
    {
        [_iBackBtn setHidden:hasBack];
    }
}

- (void)awakeFromNib
{
    _hasBack = YES;
    [_iLoadingActivity setHidden:YES];
    [_iLoadingActivity stopAnimating];
}

- (void) _viewInfo:(NetUserRequest *)request
{
    [[TipViewManager defaultManager] hideTipWithID:self
                                         animation:YES];
    if (!_userInfo)
    {
        self.userInfo = [[GEMTUserInfo alloc] init];
    }
    [_userInfo setUserInfoWithLoginResPonse:request.responseData.detailResponse.userInfo];
    if ([_userInfo.userId intValue] == [[GEMTUserManager defaultManager].userInfo.userId intValue] )
    {
        _eType = followRelation_Own;
        [GEMTUserManager defaultManager].userInfo = _userInfo;
        [[GEMTUserManager defaultManager] userInfoWirteToFile];
    }else
    {
        _eType = request.responseData.detailResponse.isFollow?followRelation_follow:followRelation_unFollow;
    }
    [self resetInfo];
}


- (void)NetUserRequestSuccess:(NetUserRequest *)request
{
    if (request.requestType == NetUserRequestType_ViewInfo)
    {
        [self _viewInfo:request];
    }else if (request.requestType == NetUserRequestType_UnFollow)
    {
        _eType = followRelation_unFollow;
        [_iLoadingActivity setHidden:YES];
        [_iLoadingActivity stopAnimating];
        [_followBtn setEnabled:YES];
        [_followBtn setTitle:@"加关注" forState:UIControlStateNormal];
        [_followBtn setTitle:@"加关注" forState:UIControlStateHighlighted];
    }else if (request.requestType == NetUserRequestType_Follow)
    {
        _eType = followRelation_unFollow;
        [_iLoadingActivity setHidden:YES];
        [_iLoadingActivity stopAnimating];
        [_followBtn setEnabled:YES];
        [_followBtn setTitle:@"取消关注" forState:UIControlStateNormal];
        [_followBtn setTitle:@"取消关注" forState:UIControlStateHighlighted];
    }else if (request.requestType == NetUserRequestType_Zan)
    {
        _iPraiseLb.text = [NSString stringWithFormat:@"%d",[_iPraiseLb.text intValue]+1];
    }
}

- (void)NetUserRequestFail:(NetUserRequest *)request
{
    if (request.requestType == NetUserRequestType_ViewInfo)
    {
        [[TipViewManager defaultManager] showTipText:@"网络繁忙"
                                           imageName:@""
                                              inView:self
                                                  ID:self];
        [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
    }else if (request.requestType == NetUserRequestType_UnFollow)
    {
        [_iLoadingActivity setHidden:YES];
        [_iLoadingActivity stopAnimating];
        [_followBtn setEnabled:NO];
    }else if (request.requestType == NetUserRequestType_Follow)
    {
        [_iLoadingActivity setHidden:YES];
        [_iLoadingActivity stopAnimating];
        [_followBtn setEnabled:NO];
    }
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




- (IBAction)followOther:(UIButton*)sender
{
    if([[sender titleForState:UIControlStateNormal] isEqualToString:@"取消关注"])
    {
        UserUnFollowRequest *request = [[UserUnFollowRequest alloc] init];
        request.delegate = self;
        request.unFollowId = _userInfo.userId;
        [[NetRequestManager defaultManager] startRequest:request];

    }
    else
    {
        UserFollowRequest *follow = [[UserFollowRequest alloc] init];
        follow.followId = _userInfo.userId;
        follow.delegate = self;
        [[NetRequestManager defaultManager] startRequest:follow];
    }
   
}

- (IBAction)pariseOthers:(UIButton*)sender
{
    UserZanRequest *request = [[UserZanRequest alloc] init];
    sender.enabled = NO;
    request.zanUserId = _userInfo.userId;
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



- (void)MapView:(MapView *)view
       location:(CLLocationCoordinate2D)aLocation
       loactionAddr:(NSString *)aStr
{
    NSLog(@"%lf,%lf,%@",aLocation.latitude,aLocation.longitude,aStr);
}

- (void)PicChangeSuccess:(PicChange *)self img:(UIImage *)img
{
    _iAvatarImage.image = img;
}

- (IBAction)editInfoBtnDidPressed:(id)sender
{
    UserEditUserInfoView *editInfo = [UserEditUserInfoView loadFromNib];
    editInfo.delegate = self;
    editInfo.panGesture = self.panGesture;
    [[UIView rootController] pushViewController:editInfo animated:YES];
}


- (IBAction)sendMsgBtnDidPressed:(id)sender
{
    NSString *str = [sender titleForState:UIControlStateNormal];
    if ([str isEqualToString:@"发消息"])
    {
        ChatViewController *chatView = [ChatViewController loadFromNib];
        [[UIView rootController] pushViewController:chatView animated:YES];
        
        chatView.userID = _userInfo.userId;
        chatView.nickname = _userInfo.nickName;
    }else{
        [[GEMTUserManager defaultManager] LoginOut];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_userDidLoginOut object:nil];
    }
}

- (void)UserEditDidSuccess:(UserEditUserInfoView *)v userInfo:(GEMTUserInfo *)userInfo
{
    self.userInfo = userInfo;
    [self resetInfo];
}




@end
