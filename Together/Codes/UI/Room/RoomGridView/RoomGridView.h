//
//  RoomGridView.h
//  Together
//
//  Created by Gnef_jp on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//


#import "NetRoomRequest.h"
#import "NetRoomList.h"

@interface RoomGridView : UIView <NetRoomRequestDelegate>
{
    __weak IBOutlet UILabel *_noLocationLabel;
    RoomType                _roomType;
    NSInteger               _range;
}

@property (strong, nonatomic) NetRoomList           *roomList;
@property (weak, nonatomic) IBOutlet UITableView    *roomsTableView;

- (void) refreshGrid;

@end
