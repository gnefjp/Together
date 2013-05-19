//
//  RoomCommentView.m
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "TipViewManager.h"

#import "RoomCommentView.h"
#import "RoomCommentCell.h"

#import "NetRoomList.h"
#import "NetMessageList.h"

@implementation RoomCommentView


- (void) dealloc
{
    [[TipViewManager defaultManager] removeTipWithID:self];
}


- (void) awakeFromNib
{
    _commentList = [[NetMessageList alloc] init];
}


- (void) setRoomItem:(NetRoomItem *)roomItem
{
    _roomItem = roomItem;
    
    [self loadNextPage];
}


- (void) loadNextPage
{
    // 模拟数据
    for (int i = 0; i < 3; ++i)
    {
        NetMessageItem *item = [[NetMessageItem alloc] init];
        item.ID = [NSString stringWithInt:_commentList.list.count];
        item.messageType = (i % MessageType_Max);
        item.content = [NSString stringWithFormat:@"测试内容 %d", _commentList.list.count];
        item.sendTime = [NSString stringWithFormat:@"%d 分钟前", i + 1];
        
        item.senderID = [NSString stringWithInt:i];
        item.senderNickname = [NSString stringWithFormat:@"%d 号测试人员", i];
        item.senderAvatarID = @"1";
        
        item.receiverID = _roomItem.ID;
        
        [_commentList addItem:item];
    }
    
    
    [_commentTableView reloadData];
    
    [self _changeFrame];
}


- (void) _changeFrame
{
    [self performBlock:^{
        CGSize size = _commentTableView.contentSize;
        size.height = MAX(134.0, size.height);
        
        [self.delegate RoomCommentView:self contentSizeChange:size];
        _commentTableView.frameHeight = size.height;
        self.frameHeight = size.height;
    }afterDelay:0.1];
}


- (void) insertItemAtFirstAnimation
{
    NSMutableArray* insertArr = [[NSMutableArray alloc] init];
    [insertArr addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [_commentTableView beginUpdates];
    [_commentTableView insertRowsAtIndexPaths:insertArr
                             withRowAnimation:UITableViewRowAnimationTop];
    [_commentTableView endUpdates];
    
    [self performBlock:^{
        [_commentTableView reloadData];
        [self _changeFrame];
    }afterDelay:0.2];
}


- (CGFloat) _cellHeightWithComment:(NetMessageItem *)commentItem
{
    if (commentItem.messageType == MessageType_Sound)
    {
        return 50.0;
    }
    
    RoomCommentCell *cell = [RoomCommentCell loadFromNib];
    cell.contentLabel.text = commentItem.content;
    [cell.contentLabel changeFrameHeightWithText];
    
    return cell.contentLabel.frameHeight + 32.0;
}


#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self _cellHeightWithComment:
            (NetMessageItem *)[_commentList itemAtIndex:indexPath.row]];
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentList.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"RoomCommentIdentifier";
    
    RoomCommentCell *cell = (RoomCommentCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [RoomCommentCell loadFromNib];
    }
    cell.messageItem = (NetMessageItem *)[_commentList itemAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark- 

@end
