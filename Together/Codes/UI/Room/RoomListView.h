//
//  RoomListView.h
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

@class RoomGridView;
@interface RoomListView : UIView
{
    RoomGridView        *_defaultRoomGridView;
    RoomGridView        *_searchRoomGridView;
}

- (IBAction)createRoomBtnPressed:(id)sender;

@end
