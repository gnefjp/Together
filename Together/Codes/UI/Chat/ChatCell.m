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
#define kChatText_LabelTag      1002
#define kChatSound_BtnTag       1003

- (void) awakeFromNib
{
    UIImageView *chatBg1 = [_targetView viewWithTag:kChatBg_ImageViewTag recursive:NO];
    UIImageView *chatBg2 = [_myView viewWithTag:kChatBg_ImageViewTag recursive:NO];
    
    chatBg1.image = [chatBg1.image stretchableImageWithLeftCapWidth:30 topCapHeight:30];
    chatBg2.image = [chatBg2.image stretchableImageWithLeftCapWidth:30 topCapHeight:30];
}


- (void) _setMessagetType
{
    BOOL isMyMessage = [_messageItem.senderID isEqualToString:[GEMTUserManager defaultManager].userInfo.userId];
    UIView *mainView = isMyMessage ? _myView : _targetView;
    
    UILabel *textLabel = [mainView viewWithTag:kChatText_LabelTag recursive:NO];
    UIImageView *bgImageView = [mainView viewWithTag:kChatBg_ImageViewTag recursive:NO];
    UIButton *soundBtn = [mainView viewWithTag:kChatSound_BtnTag recursive:NO];
    
    textLabel.hidden = (_messageItem.messageType == MessageType_Sound);
    bgImageView.hidden = (_messageItem.messageType == MessageType_Sound);
    soundBtn.hidden = (_messageItem.messageType == MessageType_Text);
    
    if (_messageItem.messageType == MessageType_Text)
    {
        // 信息
        textLabel.text = _messageItem.content;
        [textLabel changeFrameHeightWithText];
        
        int width = 190.0;
        if (textLabel.frameHeight < 30)
        {
            [textLabel changeFrameWithText];
            width= textLabel.frameWidth;
            textLabel.frameWidth = 190;
            
            textLabel.textAlignment = isMyMessage ? NSTextAlignmentRight : NSTextAlignmentLeft;
        }
        else
        {
            textLabel.textAlignment = NSTextAlignmentLeft;
        }
        
        // 背景
        bgImageView.frameSize = CGSizeMake(MAX(width + 30, 60),
                                           MAX(textLabel.frameHeight + 22, 44));
        
        if (isMyMessage)
        {
            bgImageView.frameX = 232.0 - bgImageView.frameWidth;
        }
    }
    else
    {
        
    }
}


- (void) setMessageItem:(NetMessageItem *)messageItem
{
    _messageItem = messageItem;
    
    BOOL isMyMessage = [messageItem.senderID isEqualToString:[GEMTUserManager defaultManager].userInfo.userId];
    
    _targetView.hidden = isMyMessage;
    _myView.hidden = !isMyMessage;
    
    _sendTimeLabel.text = _messageItem.sendTime;
    
    UIView *mainView = isMyMessage ? _myView : _targetView;
    
    // 头像
    UIImageView *avatarImageView = [mainView viewWithTag:kAvart_ImageViewTag recursive:NO];
    [avatarImageView setImageWithFileID:_messageItem.senderAvatarID
                       placeholderImage:[UIImage imageNamed:kDefaultUserAvatar]];
    
    [self _setMessagetType];
}


@end
