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
    for (int i = 0; i < 150; i++)
    {
        NetMessageItem *item = [[NetMessageItem alloc] init];
        item.ID = [NSString stringWithFormat:@"locak_%p", item];
        item.messageType = MessageType_Text;
        item.content = @"非常非常长的中文测试非常非常长的中文测试非常非常长的中文测试";
        item.senderID = @"2";
        item.senderNickname = @"测试账号";
        item.senderAvatarID = @"1";
        item.unreadNum = i % 150 + 1;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        item.sendTime = [dateFormatter stringFromDate:[NSDate date]];
        
        item.receiverID = [GEMTUserManager defaultManager].userInfo.userId;
        
        [_messageList addItem:item];
    }
    
    [_messageTableView reloadData];
    
    return;
    [[TipViewManager defaultManager] showTipText:nil imageName:nil inView:self ID:self];
    
    MessageGetListRequest *getListRequest = [[MessageGetListRequest alloc] init];
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
    
    // TODO: 获取成功
}


#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NetMessageItem *item = (NetMessageItem *) [_messageList itemAtIndex:indexPath.row];
    item.unreadNum = 0;
    
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
