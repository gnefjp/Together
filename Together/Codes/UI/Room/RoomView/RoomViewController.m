//
//  RoomViewController.m
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "CommonTool.h"
#import "TipViewManager.h"

#import "RoomViewController.h"
#import "JoinPersonView.h"
#import "ChatInputView.h"

#import "GEMTUserManager.h"

#import "RoomJoinRequest.h"
#import "RoomQuitReqeust.h"
#import "RoomCommentView.h"

#define kJoin_BtnTag        1000
#define kQuit_BtnTag        1001
#define kStart_BtnTag       1002

@implementation RoomViewController

- (void) dealloc
{
    [[TipViewManager defaultManager] removeTipWithID:self];
}


- (void)viewDidUnload
{
    [self setRoomTitleLabel:nil];
    [self setDetailAddLabel:nil];
    [self setBeginTimeLabel:nil];
    [self setCreateTimeLabel:nil];
    [self setNicknameLabel:nil];
    [self setOwerAvatarImageView:nil];
    [self setRoomPreviewImageView:nil];
    [_joinPersonView removeFromSuperview];
    _joinPersonView = nil;
    
    [[TipViewManager defaultManager] removeTipWithID:self];
    
    [self setJoinPersonNumLabel:nil];
    _mainScrollView = nil;
    [super viewDidUnload];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chatInputView = [ChatInputView loadFromNib];
    [self.view addSubview:_chatInputView];
}


- (void) _setRoomRelation
{
    UIButton *joinBtn = [_mainScrollView viewWithTag:kJoin_BtnTag recursive:NO];
    UIButton *quitBtn = [_mainScrollView viewWithTag:kQuit_BtnTag recursive:NO];
    UIButton *startBtn = [_mainScrollView viewWithTag:kStart_BtnTag recursive:NO];
    
    BOOL isWaiting = (_roomItem.roomState == RoomState_Waiting);
    
    joinBtn.alpha = (isWaiting && _roomItem.relationWitMe == RoomRelationType_NoRelation) ? 1.0 : 0.0;
    quitBtn.alpha = (isWaiting && _roomItem.relationWitMe == RoomRelationType_Joined) ? 1.0 : 0.0;
    startBtn.alpha = (isWaiting && _roomItem.relationWitMe == RoomRelationType_MyRoom) ? 1.0 : 0.0;
}


- (void) _setJoinPersonNum
{
    if (_roomItem.personLimitNum <= 0)
    {
        _joinPersonNumLabel.text = [NSString stringWithFormat:@"  %d 人 / 不限",
                                    _roomItem.joinPersonNum];
    }
    else
    {
        _joinPersonNumLabel.text = [NSString stringWithFormat:@"  %d 人 / %d 人",
                                    _roomItem.joinPersonNum,
                                    _roomItem.personLimitNum];
    }
}


- (void) _showPersonView
{
    [_joinPersonView removeFromSuperview];
    
    _joinPersonView = [JoinPersonView loadFromNib];
    _joinPersonView.frameOrigin = CGPointMake(0, 296);
    [_mainScrollView addSubview:_joinPersonView];
    
    _joinPersonView.roomID = _roomItem.ID;
}


- (void) _showCommentView
{
    [_commentView removeFromSuperview];
    
    _commentView = [RoomCommentView loadFromNib];
    _commentView.frameY = 370.0;
    _commentView.delegate = self;
    _commentView.roomID = _roomItem.ID;
    
    [_mainScrollView addSubview:_commentView];
}


- (void) setRoomItem:(NetRoomItem *)roomItem
{
    _roomItem = roomItem;
    
    self.roomTitleLabel.text = _roomItem.roomTitle;
    
    self.beginTimeLabel.text = _roomItem.beginTime;
    [self.beginTimeLabel changeFrameWithText];
    self.beginTimeLabel.frameWidth += 10;
    
    self.detailAddLabel.text = _roomItem.address.detailAddr;
    [self.detailAddLabel changeFrameWithText];
    self.detailAddLabel.frameWidth += 10;
    
    [self.roomPreviewImageView setImageWithFileID:_roomItem.perviewID
                                 placeholderImage:[UIImage imageNamed:@"room_create_pic_default.png"]];
    
    self.createTimeLabel.text = _roomItem.createTime;
    self.nicknameLabel.text = _roomItem.ownerNickname;
    
    [self _setRoomRelation];
    
    [self _setJoinPersonNum];
    [self _showPersonView];
    
    [self _showCommentView];
}


- (IBAction)closeBtnPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)joinBtnDidPressed:(id)sender
{
    if (_roomItem.joinPersonNum == _roomItem.personLimitNum)
    {
        [[TipViewManager defaultManager] showTipText:@"人数已满"
                                           imageName:kCommonImage_FailIcon
                                              inView:self.view
                                                  ID:self];
        [[TipViewManager defaultManager] hideTipWithID:self animation:YES delay:1.25];
        return;
    }
    
    [[TipViewManager defaultManager] showTipText:nil
                                       imageName:nil
                                          inView:self.view
                                              ID:self];
    
    RoomJoinRequest *joinRequest = [[RoomJoinRequest alloc] init];
    joinRequest.userID = [GEMTUserManager defaultManager].userInfo.userId ;
    joinRequest.roomID = _roomItem.ID;
    joinRequest.sid = [GEMTUserManager defaultManager].sId;
    joinRequest.delegate = self;
    
    [[NetRequestManager defaultManager] startRequest:joinRequest];
}


- (IBAction)quitBtnDidPressed:(id)sender
{
    [[TipViewManager defaultManager] showTipText:nil
                                       imageName:nil
                                          inView:self.view
                                              ID:self];
    
    RoomJoinRequest *joinRequest = [[RoomJoinRequest alloc] init];
    joinRequest.userID = [GEMTUserManager defaultManager].userInfo.userId ;
    joinRequest.roomID = _roomItem.ID;
    joinRequest.sid = [GEMTUserManager defaultManager].sId;
    joinRequest.delegate = self;
    
    [[NetRequestManager defaultManager] startRequest:joinRequest];
}


- (IBAction)startBtnDidPressed:(id)sender
{
}


- (IBAction)playRoomSound:(id)sender
{
}


- (IBAction)chatDidPressed:(id)sender
{
}


#pragma mark- RoomCommentViewDelegate
- (void) RoomCommentView:(RoomCommentView *)roomCommentView contentSizeChange:(CGSize)contentSize
{
    contentSize.height += 370;
    NSLog(@"contentSize.height : %lf", contentSize.height);
    _mainScrollView.contentSize = contentSize;
}


#pragma mark- NetRoomRequestDelegate
- (void) NetRoomRequestFail:(NetRoomRequest *)request
{
    NSString *msg = @"请求失败";
    
    if (request.requestType == NetRoomRequestType_JoinRoom)
    {
        msg = @"加入失败";
    }
    else if (request.requestType == NetRoomRequestType_QuitRoom)
    {
        msg = @"退出失败";
    }
    
    [[TipViewManager defaultManager] showTipText:msg
                                       imageName:kCommonImage_FailIcon
                                          inView:self.view
                                              ID:self];
    
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES delay:1.25];
}


- (void) NetRoomRequestSuccess:(NetRoomRequest *)request
{
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
    if (request.requestType == NetRoomRequestType_JoinRoom)
    {
        _roomItem.relationWitMe = RoomRelationType_Joined;
        [self _setRoomRelation];
    }
    else if (request.requestType == NetRoomRequestType_QuitRoom)
    {
        _roomItem.relationWitMe = RoomRelationType_NoRelation;
        [self _setRoomRelation];
    }
}


@end
