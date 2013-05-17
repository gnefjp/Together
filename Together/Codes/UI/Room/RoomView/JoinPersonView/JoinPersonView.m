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
#import "NetItemList.h"


#pragma mark- PersonView
@interface PersonView : UIView
{
    UIImageView *_bgImageView;
    UIImageView *_avatarImageView;
}

@property (strong, nonatomic) NetItem   *userItem;

@end

@implementation PersonView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _avatarImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _avatarImageView.image = [UIImage imageNamed:@"userDefaultPhoto.png"];
        [self addSubview:_avatarImageView];
        
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.image = [UIImage imageNamed:@"userCenter_avatarBg.png"];
        [self addSubview:_bgImageView];
    }
    return self;
}


- (void) setUserItem:(NetItem *)userItem
{
    _userItem = userItem;
    
    [_avatarImageView setImageWithFileID:userItem.ID
                        placeholderImage:[UIImage imageNamed:@"userDefaultPhoto.png"]];
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
    _userList = [[NetItemList alloc] init];
    
// 模拟数据
    for (int i = 0; i < 20; i ++)
    {
        NetItem *item = [[NetItem alloc] init];
        item.ID = [NSString stringWithInt:i];
        [_userList addItem:item];
    }
}


- (void) setRoomID:(NSString *)roomID
{
    _roomID = roomID;
    
    [self reloadDidPressed:nil];
}


- (IBAction)showMoreJoinPerson:(id)sender
{
    JoinPersonViewController *joinPersonViewController = [JoinPersonViewController loadFromNib];
    [[UIView rootController] pushViewController:joinPersonViewController animated:YES];
}


- (IBAction)reloadDidPressed:(id)sender
{
    [self _isShow:NO animation:NO];
    
    _reloadBtn.hidden = YES;
    _loadingActivityIndicator.hidden = NO;
    [_loadingActivityIndicator startAnimating];
    
    RoomGetJoinPersonsRequest *getPersonsRequest = [[RoomGetJoinPersonsRequest alloc] init];
    getPersonsRequest.delegate = self;
    getPersonsRequest.roomID = _roomID;
    getPersonsRequest.sid = [[GEMTUserManager defaultManager].userInfo.userId stringValue];
    getPersonsRequest.pageNum = 0;
    getPersonsRequest.pageSize = 1000000;
    
    [[NetRequestManager defaultManager] startRequest:getPersonsRequest];
}


- (void) _reloadData
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
        personView.userItem = [_userList itemAtIndex:i];
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
    
    [self _reloadData];
}
@end





