//
//  RoomCommentCell.h
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NetMessageItem;
@interface RoomCommentCell : UITableViewCell

@property (strong, nonatomic) NetMessageItem        *messageItem;
@property (weak,   nonatomic) IBOutlet UIImageView  *avatarImageView;
@property (weak,   nonatomic) IBOutlet UILabel      *senderNicknameLabel;
@property (weak,   nonatomic) IBOutlet UILabel      *contentLabel;
@property (weak,   nonatomic) IBOutlet UILabel      *sendTimeLabel;
@property (weak,   nonatomic) IBOutlet UIButton     *recordBtn;

- (IBAction)playRecordDidPressed:(id)sender;

@end
