//
//  JoinPersonView.m
//  Together
//
//  Created by Gnef_jp on 13-5-15.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "GEMTUserManager.h"

#import "JoinPersonView.h"

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
}


- (void) setRoomID:(NSString *)roomID
{
    _roomID = roomID;
    
    [self reloadDidPressed:nil];
}


- (IBAction)showMoreJoinPerson:(id)sender
{
    
}


- (IBAction)reloadDidPressed:(id)sender
{
    [self _isShow:NO animation:NO];
    
    _reloadBtn.hidden = YES;
    _loadingActivityIndicator.hidden = NO;
    [_loadingActivityIndicator startAnimating];
    
    RoomGetJoinPersonsRequest *getPersonsRequest = [[RoomGetJoinPersonsRequest alloc] init];
    getPersonsRequest.roomID = _roomID;
    getPersonsRequest.sid = [[GEMTUserManager defaultManager].userInfo.userId stringValue];
    getPersonsRequest.pageNum = 0;
    getPersonsRequest.pageSize = 1000000;
    
    [[NetRequestManager defaultManager] startRequest:getPersonsRequest];
}


#pragma mark- NetRoomRequestDelegate
- (void) NetRoomRequestFail:(NetRoomRequest *)request
{
    _reloadBtn.hidden = YES;
    _loadingActivityIndicator.hidden = YES;
    [_loadingActivityIndicator stopAnimating];
}


- (void) NetRoomRequestSuccess:(NetRoomRequest *)request
{
    _loadingActivityIndicator.hidden = YES;
    [_loadingActivityIndicator stopAnimating];
    
    // TODO: 显示列表
}
@end
