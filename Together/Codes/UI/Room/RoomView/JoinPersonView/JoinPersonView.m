//
//  JoinPersonView.m
//  Together
//
//  Created by Gnef_jp on 13-5-15.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "GEMTUserManager.h"
#import "CommonTool.h"

#import "JoinPersonView.h"
#import "JoinPersonViewController.h"
#import "NetUserList.h"
#import "NetRoomList.h"


#pragma mark- PersonView
@interface PersonView : UIView
{
    UIImageView *_bgImageView;
    UIImageView *_avatarImageView;
    UIImageView *_followStateImageView;
}

@property (strong, nonatomic) NetUserItem   *userItem;

@end

@implementation PersonView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _avatarImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _avatarImageView.image = [UIImage imageNamed:kDefaultUserAvatar];
        [self addSubview:_avatarImageView];
        
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.image = [UIImage imageNamed:@"usercenter_avatarBg.png"];
        [self addSubview:_bgImageView];
        
        _followStateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(24, 24, 24, 24)];
        [self addSubview:_followStateImageView];
    }
    return self;
}


- (void) setUserItem:(NetUserItem *)userItem
{
    _userItem = userItem;
    
    [_avatarImageView setImageWithFileID:userItem.ID
                        placeholderImage:[UIImage imageNamed:kDefaultUserAvatar]];
    
    NSString *relationImages[] = {
        @"room_unfollow_btn.png",
        @"room_follow_btn.png",
    };
    
    _followStateImageView.image = [UIImage imageNamed:
                                   relationImages[(userItem.relationWithMe == UserRelationType_Follow)]];
}

@end


#pragma mark- JoinPersonView

#define kMore_BtnTag    1000
@implementation JoinPersonView


- (void) _isShow:(BOOL)isShow animation:(BOOL)animation
{
    UIButton *moreBtn = [self viewWithTag:kMore_BtnTag recursive:NO];
    
    if (animation)
    {
        [UIView animateWithDuration:1.0
                         animations:^{
                            
                             [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                             moreBtn.alpha = isShow ? 1.0 : 0.0;
                             _joinPersonsScrollView.alpha = isShow ? 1.0 : 0.0;
                             
                         }completion:^(BOOL finished){
                            
                             [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                             
                         }];
    }
    else
    {
        moreBtn.alpha = isShow ? 1.0 : 0.0;
        _joinPersonsScrollView.alpha = isShow ? 1.0 : 0.0;
    }
}


- (void) awakeFromNib
{
    _userList = [[NetUserList alloc] init];
    
// 模拟数据
    for (int i = 0; i < 20; i ++)
    {
        NetUserItem *userItem = [[NetUserItem alloc] init];
        userItem.ID = [NSString stringWithInt:i];
        userItem.userName = [NSString stringWithFormat:@"测试 %d 号", i];
        userItem.nickName = userItem.userName;
        userItem.avataId = @"1";
        userItem.relationWithMe = (i % UserRelationType_Own);
        
        [_userList addItem:userItem];
    }
}


- (void) setRoomItem:(NetRoomItem *)roomItem
{
    _roomItem = roomItem;
    
    [self reloadDidPressed:nil];
}


- (IBAction)showMoreJoinPerson:(id)sender
{
    JoinPersonViewController *joinPersonViewController = [JoinPersonViewController loadFromNib];
    [[UIView rootController] pushViewController:joinPersonViewController animated:YES];
    joinPersonViewController.joinPersonNum = _roomItem.joinPersonNum;
    joinPersonViewController.userList = _userList;
}


- (IBAction)reloadDidPressed:(id)sender
{
    [self _isShow:NO animation:NO];
    
    _reloadBtn.hidden = YES;
    _loadingActivityIndicator.hidden = NO;
    [_loadingActivityIndicator startAnimating];
    
    RoomGetJoinPersonsRequest *getPersonsRequest = [[RoomGetJoinPersonsRequest alloc] init];
    getPersonsRequest.delegate = self;
    getPersonsRequest.roomID = _roomItem.ID;
    getPersonsRequest.sid = [GEMTUserManager defaultManager].sId;
    getPersonsRequest.pageNum = 0;
    getPersonsRequest.pageSize = 1000000;
    
    [[NetRequestManager defaultManager] startRequest:getPersonsRequest];
}


- (void) reloadData
{
    // RemoveAllPersonView
    for (UIView *subview in _joinPersonsScrollView.subviews)
    {
        if ([subview isKindOfClass:[PersonView class]])
        {
            [subview removeFromSuperview];
        }
    }
    
    // AddPersonView
    CGRect frame = CGRectMake(6, 6, 40, 40);
    for (int i = 0, len = _userList.list.count; i < len; ++i)
    {
        PersonView *personView = [[PersonView alloc] initWithFrame:frame];
        personView.userItem = (NetUserItem *)[_userList itemAtIndex:i];
        [_joinPersonsScrollView addSubview:personView];
        
        frame.origin.x += 46;
    }
    
    _joinPersonsScrollView.contentSize = CGSizeMake(frame.origin.x,
                                                    _joinPersonsScrollView.frameHeight);
    
    [self _isShow:YES animation:YES];
}


#pragma mark- NetRoomRequestDelegate
- (void) NetRoomRequestFail:(NetRoomRequest *)request
{
    // TODO: 删除下边测试这句
    [self NetRoomRequestSuccess:nil];
    return;
    
    _reloadBtn.hidden = YES;
    _loadingActivityIndicator.hidden = YES;
    [_loadingActivityIndicator stopAnimating];
}


- (void) NetRoomRequestSuccess:(NetRoomRequest *)request
{
    _loadingActivityIndicator.hidden = YES;
    [_loadingActivityIndicator stopAnimating];
    
//    RoomGetJoinPersonsRequest *getListRequest = (RoomGetJoinPersonsRequest *)request;
//    [_userList addItemList:request.responseData onPage:getListRequest.pageNum];
    
    [self reloadData];
}
@end





