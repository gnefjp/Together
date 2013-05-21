//
//  RoomViewController.m
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "CommonTool.h"
#import "TipViewManager.h"
#import "AppSetting.h"

#import "NetMessageList.h"

#import "RoomViewController.h"
#import "JoinPersonView.h"
#import "ChatInputView.h"

#import "GEMTUserManager.h"

#import "RoomCommentView.h"

#import "KeepSorcket.h"

#import "NetFileManager.h"

#import "UserUnFollowRequest.h"
#import "UserFollowRequest.h"

#define kJoin_BtnTag        1000
#define kQuit_BtnTag        1001
#define kStart_BtnTag       1002

#define kLoadMoreMsgHeight  20

@implementation RoomViewController

static NSString* s_roomTypeNames[] = {
    @"roomtype_other.png",
    @"roomtype_brpg.png",
    @"roomtype_catering.png",
    @"roomtype_sports.png",
    @"roomtype_shopping.png",
    @"roomtype_movie.png",
};


- (void) dealloc
{
    [[ATTimerManager shardManager] stopTimerDelegate:self];
    
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
    _roomTypeImageView = nil;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_joinRoomSuccess)
                                                 name:kNotification_JoinRoomSuccess
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_quitRoomSuccess)
                                                 name:kNotification_QuitRoomSuccess
                                               object:nil];
}


- (void) _joinRoomSuccess
{
    _roomItem.joinPersonNum ++;
    [self _setJoinPersonNum];
    [_joinPersonView reloadDidPressed:nil];
}


- (void) _quitRoomSuccess
{
    _roomItem.joinPersonNum --;
    [self _setJoinPersonNum];
    [_joinPersonView reloadDidPressed:nil];
}


- (void) viewDidAppear:(BOOL)animated
{
    [_joinPersonView reloadData];
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
    
    _mainScrollView.frameHeight = isRoomEnded ? 548 : 504;
    _commentView.frameHeight = MAX(178.0, _commentView.frameHeight);
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
    
    [self _remainTime];
    
    _roomTypeImageView.image = [UIImage imageNamed:s_roomTypeNames[_roomItem.roomType]];
}


- (void) _remainTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    double tmpTime = [[formatter dateFromString:_roomItem.beginTime] timeIntervalSince1970] +
                        [[NSDate date] timeIntervalSince1970] - 
                        [[AppSetting defaultSetting].serverCurrentTime doubleValue];
    NSDate *beginTime = [NSDate dateWithTimeIntervalSince1970:tmpTime];
    _roomItem.beginTime = [formatter stringFromDate:beginTime];
    
    self.beginTimeLabel.text = [_roomItem.beginTime startTimeIntervalWithClient];
    [self.beginTimeLabel changeFrameWithText];
    self.beginTimeLabel.frameWidth += 10;
    
    [[ATTimerManager shardManager] stopTimerDelegate:self];
    [[ATTimerManager shardManager] addTimerDelegate:self interval:1.0];
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
    
    [[KeepSorcket defaultManager] joinRoomWithRoomID:_roomItem.ID];
    
    _roomItem.relationWitMe = RoomRelationType_Joined;
    [self _setRoomRelation];
}


- (IBAction)quitBtnDidPressed:(id)sender
{
    [[KeepSorcket defaultManager] quitRoomWithRoomID:_roomItem.ID];
    
    _roomItem.relationWitMe = RoomRelationType_NoRelation;
    [self _setRoomRelation];
}


- (IBAction)startBtnDidPressed:(id)sender
{
    [[KeepSorcket defaultManager] startRoomWithRoomID:_roomItem.ID];
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


#pragma mark- ATTimerManagerDelegate
- (void) timerManager:(ATTimerManager*)manager timerFireWithInfo:(ATTimerStepInfo)info
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if ([[formatter dateFromString:_roomItem.beginTime] timeIntervalSince1970] <=
        [[NSDate date] timeIntervalSince1970])
    {
        self.beginTimeLabel.text = @"已开始";
        _roomItem.roomState = RoomState_Ended;
        [self _isRoomEnded:YES];
        
        [[ATTimerManager shardManager] stopTimerDelegate:self];
    }
    else
    {
        self.beginTimeLabel.text = [_roomItem.beginTime startTimeIntervalWithClient];
    }
    
    [self.beginTimeLabel changeFrameWithText];
    self.beginTimeLabel.frameWidth += 10;
}


#pragma mark- AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self _isPlayRecord:NO];
}


- (IBAction)followOwnDidPressed:(id)sender
{
    BOOL isFollowed = (_roomItem.ownerRelationWithMe == UserRelationType_Follow ||
                       _roomItem.ownerRelationWithMe == UserRelationType_FollowEach);
    
    if (isFollowed)
    {
        _roomItem.ownerRelationWithMe -= 1;
        
        UserUnFollowRequest *unFollowRequest = [[UserUnFollowRequest alloc] init];
        unFollowRequest.delegate = self;
        unFollowRequest.unFollowId = _roomItem.ownerID;
        
        [[NetRequestManager defaultManager] startRequest:unFollowRequest];
    }
    else
    {
        _roomItem.ownerRelationWithMe += 1;
        
        UserFollowRequest *followRequest = [[UserFollowRequest alloc] init];
        followRequest.delegate = self;
        followRequest.followId = _roomItem.ownerID;
        
        [[NetRequestManager defaultManager] startRequest:followRequest];
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



#pragma mark- NetUserRequestDelegate
- (void) NetUserRequestFail:(NetUserRequest*)request
{
    if (request.requestType == NetUserRequestType_Follow)
    {
        _roomItem.ownerRelationWithMe = UserRelationType_NoRelation;
    }
    else if (request.requestType == NetUserRequestType_UnFollow)
    {
        _roomItem.ownerRelationWithMe = UserRelationType_Follow;
    }
}


- (void) NetUserRequestSuccess:(NetUserRequest*)request
{
}


@end
