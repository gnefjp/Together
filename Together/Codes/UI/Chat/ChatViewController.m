//
//  ChatViewController.m
//  Together
//
//  Created by Gnef_jp on 13-5-19.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "TipViewManager.h"
#import "GEMTUserManager.h"

#import "MessageGetChatListRequest.h"

#import "ChatInputView.h"
#import "NetMessageList.h"

#import "ChatViewController.h"

#import "ChatCell.h"
#import "KeepSorcket.h"

#import "MessageUpdateStateRequest.h"

@implementation ChatViewController

#define kTopRefreshHeight       10

- (void) dealloc
{
    [[TipViewManager defaultManager] removeTipWithID:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidUnload
{
    _chatTableView = nil;
    [self setTargetNicknameLabel:nil];
    
    [[TipViewManager defaultManager] removeTipWithID:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewDidUnload];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chatList = [[NetMessageList alloc] init];
    
    _chatInputView = [ChatInputView loadFromNib];
    _chatInputView.delegate = self;
    _chatInputView.isTextInput = YES;
    [self.view addSubview:_chatInputView];
    
    _chatTableView.delegate = self;
    _chatTableView.dataSource = self;
    
    _refreshView = [[SRRefreshView alloc] init];
    _refreshView.delegate = self;
    _refreshView.upInset = kTopRefreshHeight;
    [_chatTableView addSubview:_refreshView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_refreshData)
                                                 name:kNotification_SendUserMsgSuccess
                                               object:nil];
}


- (void) setUserID:(NSString *)userID
{
    _userID = userID;
    
    [self _refreshData];
}


- (void) setNickname:(NSString *)nickname
{
    _nickname = nickname;
    
    _targetNicknameLabel.text = _nickname;
}


- (NSString *) _culRoomID
{
    int myID = [[GEMTUserManager defaultManager].userInfo.userId intValue];
    int targetID = [_userID intValue];
    
    return [NSString stringWithFormat:@"%d%d", MIN(myID, targetID), MAX(myID, targetID)];
}


#pragma mark- ChatInputViewDelegate
- (void) ChatInputView:(ChatInputView *)chatInputView
               content:(NSString *)content
                isText:(BOOL)isText
{
    NetMessageItem *messageItem = [[NetMessageItem alloc] init];
    messageItem.ID = [NSString stringWithFormat:@"local_%p", messageItem];
    messageItem.messageType = !isText;
    messageItem.content = content;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    messageItem.sendTime = [dateFormatter stringFromDate:[NSDate date]];
    
    messageItem.senderID = [GEMTUserManager defaultManager].userInfo.userId;
    messageItem.senderNickname = [GEMTUserManager defaultManager].userInfo.nickName;
    messageItem.senderAvatarID = [GEMTUserManager defaultManager].userInfo.avataId;
    
    messageItem.receiverID = _userID;
    
    [_chatList addItem:messageItem];
    
    [self _reloadData];
    
    [[KeepSorcket defaultManager] sendMsgWithSenderId:messageItem.senderID
                                             receipId:messageItem.receiverID
                                               roomId:[self _culRoomID]
                                              msgType:GetMessageType_Single
                                              content:messageItem.content];
}


- (void) ChatInputView:(ChatInputView *)chatInputView changeOriginY:(CGFloat)originY
{
    _chatTableView.frameHeight = 456.0 + originY;
    
    CGFloat offsetY = _chatTableView.contentSize.height - _chatTableView.frameHeight;
    _chatTableView.contentOffset = CGPointMake(0, MAX(0.0, offsetY));
}


#pragma mark- request
- (void) _reloadData
{
    [_chatTableView reloadData];
    
    [self performBlock:^{
        
        if (_chatList.list.count > 0)
        {
            NSIndexPath *tmpPath = [NSIndexPath indexPathForRow:_chatList.list.count - 1 inSection:0];
            [_chatTableView scrollToRowAtIndexPath:tmpPath
                                  atScrollPosition:UITableViewScrollPositionBottom
                                          animated:YES];
        }
        
    }afterDelay:0.2];
}


- (void) _refreshData
{
    [self _getChatsWithDirect:GetListDirect_Last];
}


- (void) _getChatsWithDirect:(GetListDirect)getListDirect
{
    MessageGetChatListRequest *getListRequest = [[MessageGetChatListRequest alloc] init];
    getListRequest.delegate = self;
    
    getListRequest.getMessagetType = GetMessageType_Single;
    getListRequest.msgNum = 10;
    getListRequest.recipientID = [GEMTUserManager defaultManager].userInfo.userId;
    getListRequest.roomID = [self _culRoomID];
    getListRequest.getListDirect = getListDirect;
    
    
    switch (getListDirect)
    {
        case GetListDirect_Before:
        {
            int i = _chatList.list.count - 1;
            while (i >= 0)
            {
                NetMessageItem *item = (NetMessageItem *)[_chatList itemAtIndex:i];
                if (![item.ID hasPrefix:@"local_"])
                {
                    getListRequest.currentID = item.ID;
                    break;
                }
                
                -- i;
            }
            
            if (i < 0)
            {
                getListRequest.getListDirect = GetListDirect_Last;
                getListRequest.currentID = @"0";
            }
            break;
        }
        case GetListDirect_Later:
        {
            int i = 0, len = _chatList.list.count;
            while (i < len)
            {
                NetMessageItem *item = (NetMessageItem *)[_chatList itemAtIndex:i];
                if (![item.ID hasPrefix:@"local_"])
                {
                    getListRequest.currentID = item.ID;
                    break;
                }
                
                ++ i;
            }
            
            if (i == len)
            {
                getListRequest.getListDirect = GetListDirect_Last;
                getListRequest.currentID = @"0";
            }
            break;
        }
        default:
        {
            getListRequest.currentID = @"0";
            break;
        }
    }
    
    [[NetRequestManager defaultManager] startRequest:getListRequest];
}


#pragma mark- NetMessageRequestDelegate
- (void) NetMessageRequestFail:(NetRequest *)request
{
    [_refreshView endRefresh];
    
    [[TipViewManager defaultManager] showTipText:@"获取列表失败"
                                       imageName:kCommonImage_FailIcon
                                          inView:self.view
                                              ID:self];
    
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES delay:1.25];
}


- (NSString *) _culRoomIDWithTargetID:(NSString *)targetID
{
    int target = [targetID intValue];
    int mine = [[GEMTUserManager defaultManager].userInfo.userId intValue];
    
    return [NSString stringWithFormat:@"%d%d", MIN(target, mine), MAX(target, mine)];
}


- (void) _updateMsgState
{
    NetMessageItem *messageItem = [_chatList.list lastObject];
    
    MessageUpdateStateRequest *updateMsgState = [[MessageUpdateStateRequest alloc] init];
    updateMsgState.roomID = [self _culRoomIDWithTargetID:messageItem.senderID];
    updateMsgState.recipientId = [GEMTUserManager defaultManager].userInfo.userId;
    updateMsgState.msgID = messageItem.ID;
    [[NetRequestManager defaultManager] startRequest:updateMsgState];
}


- (void) NetMessageRequestSuccess:(NetRequest *)request
{
    [_refreshView endRefresh];
    
    MessageGetChatListRequest *getListRequest = (MessageGetChatListRequest *)request;
    
    [_chatList addItemList:getListRequest.responseData direct:getListRequest.getListDirect];
    
    [self _updateMsgState];
    
    [self _reloadData];
}



#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NetMessageItem *messageItem = (NetMessageItem *) [_chatList itemAtIndex:indexPath.row];
    
    UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 190, 22)];
    tmpLabel.font = [UIFont fontWithName:@"ArialMT" size:16];
    tmpLabel.text = messageItem.content;
    [tmpLabel changeFrameHeightWithText];
    
    return tmpLabel.frameHeight + 78;
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _chatList.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"ChatIdentifier";
    
    ChatCell *cell = (ChatCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [ChatCell loadFromNib];
    }
    
    cell.messageItem = (NetMessageItem *)[_chatList itemAtIndex:indexPath.row];
    
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0)
    {
        [_refreshView scrollViewDidScroll];
    }
}


- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_refreshView scrollViewDidEndDraging];
}


#pragma mark- SRRefreshViewDelegate
- (void) slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self _getChatsWithDirect:GetListDirect_Before];
}


- (IBAction)backDidPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
