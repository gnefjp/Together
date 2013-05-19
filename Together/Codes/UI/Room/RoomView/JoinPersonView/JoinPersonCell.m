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
    
    [self _setUserRelation];
}


- (void) _setUserRelation
{
    _relationBtn.hidden = (_userItem.relationWithMe == UserRelationType_Own);
    
    NSString *followImages[] = {
        @"room_unfollow_btn.png",
        @"room_follow_btn.png",
    };
    
    BOOL isFollowed = (_userItem.relationWithMe == UserRelationType_Follow ||
                       _userItem.relationWithMe == UserRelationType_FollowEach);
    [_relationBtn setImage:[UIImage imageNamed:followImages[isFollowed]]
                  forState:UIControlStateNormal];
    
    [_relationBtn setImage:[UIImage imageNamed:followImages[isFollowed]]
                  forState:UIControlStateHighlighted];
}


- (IBAction)followDidPressed:(id)sender
{
    BOOL isFollowed = (_userItem.relationWithMe == UserRelationType_Follow ||
                       _userItem.relationWithMe == UserRelationType_FollowEach);
    _userItem.relationWithMe += isFollowed ? -1 : 1;
    
    [self _setUserRelation];
}
@end
