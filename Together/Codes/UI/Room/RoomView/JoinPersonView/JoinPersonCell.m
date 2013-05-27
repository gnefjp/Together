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

#import "UserUnFollowRequest.h"
#import "UserFollowRequest.h"

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
    
    if (isFollowed)
    {
        _userItem.relationWithMe -= 1;
        
        UserUnFollowRequest *unFollowRequest = [[UserUnFollowRequest alloc] init];
        unFollowRequest.delegate = self;
        unFollowRequest.unFollowId = _userItem.ID;
        
        [[NetRequestManager defaultManager] startRequest:unFollowRequest];
    }
    else
    {
        _userItem.relationWithMe += 1;
        
        UserFollowRequest *followRequest = [[UserFollowRequest alloc] init];
        followRequest.delegate = self;
        followRequest.followId = _userItem.ID;
        
        [[NetRequestManager defaultManager] startRequest:followRequest];
    }
    
    [self _setUserRelation];
}


#pragma mark- NetUserRequestDelegate
- (void) NetUserRequestFail:(NetUserRequest*)request
{
    if (request.requestType == NetUserRequestType_Follow)
    {
        UserFollowRequest *followRequest = (UserFollowRequest *) request;
        if ([_userItem.ID isEqualToString:followRequest.followId])
        {
            _userItem.relationWithMe = UserRelationType_NoRelation;
        }
    }
    else if (request.requestType == NetUserRequestType_UnFollow)
    {
        UserUnFollowRequest *unFollowRequest = (UserUnFollowRequest *)request;
        if ([_userItem.ID isEqualToString:unFollowRequest.unFollowId])
        {
            _userItem.relationWithMe = UserRelationType_Follow;
        }
    }
}


- (void) NetUserRequestSuccess:(NetUserRequest*)request
{
    
}
@end
