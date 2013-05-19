//
//  RoomViewController.m
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "CommonTool.h"
#import "TipViewManager.h"

#import "NetMessageList.h"

#import "RoomViewController.h"
#import "JoinPersonView.h"
#import "ChatInputView.h"

#import "GEMTUserManager.h"

#import "RoomJoinRequest.h"
#import "RoomQuitReqeust.h"
#import "RoomCommentView.h"

#import "KeepSorcket.h"

#import "NetFileManager.h"

#define kJoin_BtnTag        1000
#define kQuit_BtnTag        1001
#define kStart_BtnTag       1002

#define kLoadMoreMsgHeight  20

@implementation RoomViewController

- (void) dealloc
{
    [[TipViewManager defaultManager] removeTipWithID:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self setJoinPersonNumLabel:nil];
    _mainScrollView = nil;
    _followBtn = nil;
    _recordBtn = nil;
    [super viewDidUnload];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chatInputView = [ChatInputView loadFromNib];
    _chatInputView.delegate = self;
    _chatInputView.isTextInput = YES;
    [self.view addSubview:_chatInputView];
    
    _mainScrollView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_refreshCommentData)
                                                 name:kNotification_SendGroupMsgSuccess
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_startRoom)
                                                 name:kNotification_StartRoomSuccess
                                               object:nil];
}


- (void) _refreshCommentData
{
    [_commentView getCommentsWithDirect:GetListDirect_Last];
}


- (void) _isRoomEnded:(BOOL)isRoomEnded
{
    _chatInputView.hidden = isRoomEnded;
    
    UIButton *joinBtn = [_mainScrollView viewWithTag:kJoin_BtnTag recursive:NO];
    UIButton *quitBtn = [_mainScrollView viewWithTag:kQuit_BtnTag recursive:NO];
    UIButton *startBtn = [_mainScrollView viewWithTag:kStart_BtnTag recursive:NO];
    
    joinBtn.hidden = isRoomEnded;
    quitBtn.hidden = isRoomEnded;
    startBtn.hidden = isRoomEnded;
}


- (void) _startRoom
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _roomItem.beginTime = [formatter stringFromDate:[NSDate date]];
    _roomItem.roomState = RoomState_Ended;
    
    [self _isRoomEnded:YES];
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
    
    _followBtn.hidden = (_roomItem.relationWitMe == RoomRelationType_MyRoom);
}


- (void) _setOwnerRelation
{
    NSString *followImages[] = {
        @"room_unfollow_btn.png",
        @"room_follow_btn.png",
    };
    
    BOOL isFollowed = (_roomItem.ownerRelationWithMe == UserRelationType_Follow ||
                       _roomItem.ownerRelationWithMe == UserRelationType_FollowEach);
    [_followBtn setImage:[UIImage imageNamed:followImages[isFollowed]]
                forState:UIControlStateNormal];
    
    [_followBtn setImage:[UIImage imageNamed:followImages[isFollowed]]
                forState:UIControlStateHighlighted];
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
    
    _joinPersonView.roomItem = _roomItem;
}


- (void) _showCommentView
{
    [_commentView removeFromSuperview];
    
    _commentView = [RoomCommentView loadFromNib];
    _commentView.frameY = 370.0;
    _commentView.delegate = self;
    _commentView.roomItem = _roomItem;
    
    [_mainScrollView addSubview:_commentView];
}


- (void) setRoomItem:(NetRoomItem *)roomItem
{
    _roomItem = roomItem;
    
    self.roomTitleLabel.text = _roomItem.roomTitle;
    
    self.beginTimeLabel.text = [_roomItem.beginTime startTimeIntervalWithServer];
    [self.beginTimeLabel changeFrameWithText];
    self.beginTimeLabel.frameWidth += 10;
    
    self.detailAddLabel.text = _roomItem.address.detailAddr;
    [self.detailAddLabel changeFrameWithText];
    self.detailAddLabel.frameWidth += 10;
    
    [self.roomPreviewImageView setImageWithFileID:_roomItem.perviewID
                                 placeholderImage:[UIImage imageNamed:@"room_create_pic_default.png"]];
    
    self.createTimeLabel.text = [_roomItem.createTime timeIntervalWithServer];
    self.nicknameLabel.text = _roomItem.ownerNickname;
    
    [self _setRoomRelation];
    [self _setOwnerRelation];
    
    [self _setJoinPersonNum];
    [self _showPersonView];
    
    [self _showCommentView];
    
    [self _isRoomEnded:(_roomItem.roomState == RoomState_Ended)];
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
    
    RoomQuitReqeust *quitRequest = [[RoomQuitReqeust alloc] init];
    quitRequest.userID = [GEMTUserManager defaultManager].userInfo.userId ;
    quitRequest.roomID = _roomItem.ID;
    quitRequest.sid = [GEMTUserManager defaultManager].sId;
    quitRequest.delegate = self;
    
    [[NetRequestManager defaultManager] startRequest:quitRequest];
}


- (IBAction)startBtnDidPressed:(id)sender
{
    [[KeepSorcket defaultManager] sendRoomStart:_roomItem.ID];
}


- (void) _isPlayRecord:(BOOL)isPlay
{
    if (isPlay)
    {
        [_player prepareToPlay];
        [_player play];
    }
    else
    {
        [_player pause];
    }
    
    NSString *images[] = {
        @"common_play_btn.png",
        @"common_pause_btn.png",
    };
    
    [_recordBtn setImage:[UIImage imageNamed:images[isPlay]] forState:UIControlStateNormal];
    [_recordBtn setImage:[UIImage imageNamed:images[isPlay]] forState:UIControlStateHighlighted];
}


- (IBAction)playRoomSound:(id)sender
{
    if (_player == nil)
    {
        NSData *recordData = [[NetFileManager defaultManager] fileWithID:_roomItem.recordID
                                                                delegate:self];
        
        if (recordData == nil)
        {
            [[TipViewManager defaultManager] showTipText:nil imageName:nil inView:self.view ID:self];
        }
        else
        {
            _player = [[AVAudioPlayer alloc] initWithData:recordData error:nil];
            _player.delegate = self;
            
            [self _isPlayRecord:YES];
        }
    }
    else
    {
        [self _isPlayRecord:![_player isPlaying]];
    }
}



#pragma mark- AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self _isPlayRecord:NO];
}


- (IBAction)followOwnDidPressed:(id)sender
{
    // TODO:网络请求
    
    BOOL isFollowed = (_roomItem.ownerRelationWithMe == UserRelationType_Follow ||
                       _roomItem.ownerRelationWithMe == UserRelationType_FollowEach);
    
    if (isFollowed)
    {
        _roomItem.ownerRelationWithMe -= 1;
    }
    else
    {
        _roomItem.ownerRelationWithMe += 1;
    }
    
    [self _setOwnerRelation];
}



#pragma mark- NetFileManagerDelegate
- (void) NetFileManager:(NetFileManager *)fileManager fileID:(NSString *)fileID fileData:(NSData *)fileData
{
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
    
    _player = [[AVAudioPlayer alloc] initWithData:fileData error:nil];
    _player.delegate = self;
    
    [self _isPlayRecord:YES];
}


- (void) NetFileManagerFail:(NetFileManager *)fileManager
{
    [[TipViewManager defaultManager] showTipText:@"下载音频失败"
                                       imageName:kCommonImage_FailIcon
                                          inView:self.view
                                              ID:self];
    
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES delay:1.25];
}


#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y + scrollView.frameHeight >
        scrollView.contentSize.height + kLoadMoreMsgHeight)
    {
        [_commentView loadNextPage];
    }
}


#pragma mark- ChatInputViewDelegate
- (void) ChatInputView:(ChatInputView *)chatInputView
               content:(NSString *)content
                isText:(BOOL)isText
{
    NetMessageItem *message = [[NetMessageItem alloc] init];
    message.ID = [NSString stringWithFormat:@"local_%p", message];
    message.messageType = !isText;
    
    message.content = content;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    message.sendTime = [formatter stringFromDate:[NSDate date]];
    
    message.senderID =  [GEMTUserManager defaultManager].userInfo.userId;
    message.senderNickname = [GEMTUserManager defaultManager].userInfo.nickName;
    message.senderAvatarID = [GEMTUserManager defaultManager].userInfo.avataId;
    
    message.receiverID = _roomItem.ID;
    
    [_commentView.commentList addItemAtFirst:message];
    
    [_commentView insertItemAtFirstAnimation];
    
    [[KeepSorcket defaultManager] sendMsgWithSenderId:message.senderID
                                             receipId:message.senderID
                                               roomId:_roomItem.ID
                                              msgType:1
                                              content:message.content];
}


#pragma mark- RoomCommentViewDelegate
- (void) RoomCommentView:(RoomCommentView *)roomCommentView contentSizeChange:(CGSize)contentSize
{
    contentSize.height += 370;
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
