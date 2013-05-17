//
//  JoinPersonCell.m
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "CommonTool.h"

#import "NetUserList.h"

#import "JoinPersonCell.h"

@implementation JoinPersonCell

- (void) setUserItem:(NetUserItem *)userItem
{
    _userItem = userItem;
    
    [_avatarImageView setImageWithFileID:_userItem.avataId
                        placeholderImage:[UIImage imageNamed:kDefaultUserAvatar]];
    
    _nicknameLabel.text = userItem.nickName;
    
    NSString *relationImages[] = {
        @"room_unfollow_btn.png",
        @"room_follow_btn.png",
    };
    
    BOOL isFollowed = (_userItem.relationWithMe == UserRelationType_Follow);
    [_relationBtn setImage:[UIImage imageNamed:relationImages[isFollowed]]
                  forState:UIControlStateNormal];
    [_relationBtn setImage:[UIImage imageNamed:relationImages[isFollowed]]
                  forState:UIControlStateHighlighted];
}


- (IBAction)followDidPressed:(id)sender
{
    
}
@end
