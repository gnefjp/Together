//
//  RoomCommentCell.m
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "CommonTool.h"
#import "NetMessageList.h"

#import "RoomCommentCell.h"

@implementation RoomCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}


- (void) _setMessageType
{
    _recordBtn.hidden = (_messageItem.messageType == MessageType_Text);
    _contentLabel.hidden = (_messageItem.messageType == MessageType_Sound);
    
    if (_messageItem.messageType == MessageType_Sound)
    {
        self.frameHeight = 50.0;
    }
    else
    {
        _contentLabel.text = _messageItem.content;
        [_contentLabel changeFrameHeightWithText];
        
        self.frameHeight = _contentLabel.frameHeight + 32.0;
    }
}


- (void) setMessageItem:(NetMessageItem *)messageItem
{
    _messageItem = messageItem;
    
    _senderNicknameLabel.text = _messageItem.senderNickname;
    _sendTimeLabel.text = _messageItem.sendTime;
    
    [_avatarImageView setImageWithFileID:_messageItem.senderAvatarID
                        placeholderImage:[UIImage imageNamed:kDefaultUserAvatar]];
    
    [self _setMessageType];
}


- (IBAction)playRecordDidPressed:(id)sender
{
    
}
@end
