//
//  MessageCell.h
//  Together
//
//  Created by Gnef_jp on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NetMessageItem;
@interface MessageCell : UITableViewCell
{
    BOOL                                _isHiddenUnReadNum;
    __weak IBOutlet UIImageView         *_unReadCountImageView;
    __weak IBOutlet UILabel             *_unReadCountLabel;
}

@property (strong, nonatomic) NetMessageItem        *messageItem;
@property (weak, nonatomic) IBOutlet UIImageView    *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel        *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel        *sendTimeLabel;

@end
