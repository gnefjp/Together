//
//  MessageCell.m
//  Together
//
//  Created by Gnef_jp on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "NetMessageList.h"

#import "MessageCell.h"
#import "CommonTool.h"

@implementation MessageCell


- (void) awakeFromNib
{
    
}


- (void) setMessageItem:(NetMessageItem *)messageItem
{
    _messageItem = messageItem;
    
    [_avatarImageView setImageWithFileID:messageItem.senderAvatarID
                        placeholderImage:[UIImage imageNamed:kDefaultUserAvatar]];
    
    _nicknameLabel.text = messageItem.senderNickname;
    _contentLabel.text = messageItem.content;
    
    _sendTimeLabel.text = [messageItem.sendTime timeIntervalWithServer];
    
    [self _showUnReadCommentCount:_messageItem.unreadNum];
}


#pragma mark- unReadCount
- (void) _hideUnReadCount:(BOOL)isHide
{
    _unReadCountImageView.hidden = isHide;
    _unReadCountLabel.hidden = isHide;
}


- (void) _showUnReadCommentCount:(NSInteger)unReadCount
{
    if (unReadCount <= 0)
    {
        [self _hideUnReadCount:YES];
        return;
    }
    
    [self _hideUnReadCount:NO];
    
    if (unReadCount < 100)
    {
        _unReadCountLabel.text = [NSString stringWithInt:unReadCount];
    }
    else
    {
        _unReadCountLabel.text = @"99+";
    }
    
    
    CGRect frame = _unReadCountImageView.frame;
    
    if (unReadCount < 10)
    {
        _unReadCountImageView.image = [UIImage imageNamed:@"chat_unread_count_a.png"];
        frame.size.width = 26;
        frame.origin.x = _unReadCountLabel.frameOrigin.x + 6;
    }
    else
    {
        _unReadCountImageView.image = [UIImage imageNamed:@"chat_unread_count_b.png"];
        frame.size.width = 38;
        frame.origin.x = _unReadCountLabel.frameOrigin.x;
    }
    
    _unReadCountImageView.frame = frame;
}


@end
