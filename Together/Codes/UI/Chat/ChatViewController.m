//
//  ChatViewController.m
//  Together
//
//  Created by Gnef_jp on 13-5-19.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "TipViewManager.h"
#import "GEMTUserManager.h"

#import "ChatInputView.h"
#import "NetMessageList.h"

#import "ChatViewController.h"

#import "ChatCell.h"

@implementation ChatViewController


- (void) dealloc
{
    [[TipViewManager defaultManager] removeTipWithID:self];
}


- (void)viewDidUnload
{
    _chatTableView = nil;
    [self setTargetNicknameLabel:nil];
    
    [[TipViewManager defaultManager] removeTipWithID:self];
    
    [super viewDidUnload];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chatList = [[NetMessageList alloc] init];
    
    _chatInputView = [ChatInputView loadFromNib];
    _chatInputView.delegate = self;
    [self.view addSubview:_chatInputView];
    
    _chatTableView.delegate = self;
    _chatTableView.dataSource = self;
}


- (void) setUserID:(NSString *)userID
{
    _userID = userID;
    
    [self refreshData];
}


- (void) setNickname:(NSString *)nickname
{
    _nickname = nickname;
    
    _targetNicknameLabel.text = _nickname;
}


#pragma mark- ChatInputViewDelegate
- (void) ChatInputView:(ChatInputView *)chatInputView
               content:(NSString *)content
                isText:(BOOL)isText
{
    NetMessageItem *messageItem = [[NetMessageItem alloc] init];
    messageItem.ID = [NSString stringWithFormat:@"%@", messageItem];
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
    
    // TODO: 网络请求
}


- (void) ChatInputView:(ChatInputView *)chatInputView changeOriginY:(CGFloat)originY
{
    _chatTableView.frameHeight = 456.0 + originY;
}


#pragma mark- request
- (void) _reloadData
{
    [_chatTableView reloadData];
    
    [self performBlock:^{
        
        NSIndexPath *tmpPath = [NSIndexPath indexPathForRow:_chatList.list.count - 1 inSection:0];
        [_chatTableView scrollToRowAtIndexPath:tmpPath
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:YES];
        
    }afterDelay:0.2];
}


- (void) refreshData
{
    
}


- (void) _getChatsOnPage:(NSInteger)page
{
    // TODO: 发出请求
}


#pragma mark- CallBack



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


@end
