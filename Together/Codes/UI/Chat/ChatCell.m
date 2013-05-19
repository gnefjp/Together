//
//  ChatCell.m
//  Together
//
//  Created by Gnef_jp on 13-5-19.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "CommonTool.h"
#import "GEMTUserManager.h"

#import "NetMessageList.h"

#import "ChatCell.h"

@implementation ChatCell

#define kAvart_ImageViewTag     1000
#define kChatBg_ImageViewTag    1001
#define kChat_LabelTag          1002


- (void) awakeFromNib
{
    UIImageView *chatBg1 = [_targetView viewWithTag:kChatBg_ImageViewTag recursive:NO];
    UIImageView *chatBg2 = [_myView viewWithTag:kChatBg_ImageViewTag recursive:NO];
    
    chatBg1.image = [chatBg1.image stretchableImageWithLeftCapWidth:30 topCapHeight:22];
    chatBg2.image = [chatBg2.image stretchableImageWithLeftCapWidth:30 topCapHeight:22];
}


- (CGFloat) _labelWidthOnText:(NSString *)text
{
    
}


- (void) setMessageItem:(NetMessageItem *)messageItem
{
    _messageItem = messageItem;
    
    BOOL isMyMessage = [messageItem.senderID isEqualToString:[GEMTUserManager defaultManager].userInfo.userId];
    
    _targetView.hidden = isMyMessage;
    _myView.hidden = !isMyMessage;
    
    _sendTimeLabel.text = _messageItem.sendTime;
    
    UIView *mainView = isMyMessage ? _myView : _targetView;
    UIImageView *avatarImageView = [mainView viewWithTag:kAvart_ImageViewTag recursive:NO];
    [avatarImageView setImageWithFileID:_messageItem.senderAvatarID
                       placeholderImage:[UIImage imageNamed:kDefaultUserAvatar]];
}


@end
