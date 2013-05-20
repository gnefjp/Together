//
//  MessageView.m
//  Together
//
//  Created by Gnef_jp on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "TipViewManager.h"
#import "GEMTUserManager.h"

#import "NetMessageList.h"

#import "MessageCell.h"
#import "MessageView.h"

#import "ChatViewController.h"
#import "MessageUpdateStateRequest.h"

@implementation MessageView
@synthesize delegate = _delegate;


- (void) dealloc
{
    [[TipViewManager defaultManager] removeTipWithID:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void) awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_refreshData)
                                                 name:kNotification_SendUserMsgSuccess
                                               object:nil];
    
    _messageList = [[NetMessageList alloc] init];
    
    [self _refreshData];
}


- (IBAction)menuDidPressed:(id)sender
{
    if ([_delegate respondsToSelector:@selector(MessageViewWantShowMenu:)])
    {
        [_delegate MessageViewWantShowMenu:self];
    }
}


#pragma mark- request
- (void) _refreshData
{
    [[TipViewManager defaultManager] showTipText:nil imageName:nil inView:self ID:self];
    
    MessageGetListRequest *getListRequest = [[MessageGetListRequest alloc] init];
    getListRequest.delegate = self;
    getListRequest.recipinetID = [GEMTUserManager defaultManager].userInfo.userId;
    
    [[NetRequestManager defaultManager] startRequest:getListRequest];
}


#pragma mark- NetMessageRequestDelegate
- (void) NetMessageRequestFail:(NetRequest *)request
{
    [[TipViewManager defaultManager] showTipText:@"获取最新信息失败"
                                       imageName:kCommonImage_FailIcon
                                          inView:self
                                              ID:self];
    
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES delay:1.25];
}


- (void) NetMessageRequestSuccess:(NetRequest *)request
{
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
    
    [_messageList addItemList:request.responseData direct:GetListDirect_Last];
    [_messageTableView reloadData];
}


- (NSString *) _culRoomIDWithTargetID:(NSString *)targetID
{
    int target = [targetID intValue];
    int mine = [[GEMTUserManager defaultManager].userInfo.userId intValue];
    
    return [NSString stringWithFormat:@"%d%d", MIN(target, mine), MAX(target, mine)];
}


#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NetMessageItem *item = (NetMessageItem *) [_messageList itemAtIndex:indexPath.row];
    item.unreadNum = 0;
    
    MessageUpdateStateRequest *updateMsgState = [[MessageUpdateStateRequest alloc] init];
    updateMsgState.roomID = [self _culRoomIDWithTargetID:item.senderID];
    
    ChatViewController *chatViewController = [ChatViewController loadFromNib];
    [[UIView rootController] pushViewController:chatViewController animated:YES];
    
    chatViewController.userID = item.senderID;
    chatViewController.nickname = item.senderNickname;
    
    [tableView reloadData];
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messageList.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"MessageIdentifier";
    
    MessageCell *cell = (MessageCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [MessageCell loadFromNib];
    }
    
    cell.messageItem = (NetMessageItem *)[_messageList itemAtIndex:indexPath.row];
    
    return cell;
}
@end
