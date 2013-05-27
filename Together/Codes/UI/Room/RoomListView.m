//
//  RoomListView.m
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomListView.h"

#import "RoomCreateViewController.h"
#import "GEMTUserManager.h"


#import "ChatViewController.h"

@implementation RoomListView
@synthesize delegate = _delegate;

- (void) awakeFromNib
{
    _roomGrid = [RoomGridView loadFromNib];
    _roomGrid.frameY = 44.0;
    _roomGrid.alpha = 1.0f;
    [self addSubview:_roomGrid];
    
    [_roomGrid refreshGrid];
}


- (IBAction)showNavigationDidPressed:(id)sender
{
    if ([_delegate respondsToSelector:@selector(RoomListViewShowNavigation:)])
    {
        [_delegate RoomListViewShowNavigation:self];
    }
}


- (IBAction)createRoomBtnPressed:(id)sender
{
    if (![[GEMTUserManager defaultManager] shouldAddLoginViewToTopView])
    {
        RoomCreateViewController* createRoomControll = [RoomCreateViewController loadFromNib];
        [[UIView rootController] pushViewController:createRoomControll animated:YES];
    }
}
@end
