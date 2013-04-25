//
//  RoomListView.m
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomListView.h"
#import "RoomGridView.h"

#import "RoomCreateViewController.h"

@implementation RoomListView


- (void) awakeFromNib
{
    _defaultRoomGridView = [RoomGridView loadFromNib];
    _defaultRoomGridView.frameY = 44.0;
    _defaultRoomGridView.alpha = 1.0f;
    [self addSubview:_defaultRoomGridView];
    
    _searchRoomGridView = [RoomGridView loadFromNib];
    _searchRoomGridView.frameY = 44.0;
    _searchRoomGridView.alpha = 0.0f;
    [self addSubview:_searchRoomGridView];
}


- (IBAction)createRoomBtnPressed:(id)sender
{
    RoomCreateViewController* createRoomControll = [RoomCreateViewController loadFromNib];
    [[UIView rootController] pushViewController:createRoomControll animated:YES];
}
@end
