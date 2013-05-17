//
//  RoomGridView.h
//  Together
//
//  Created by Gnef_jp on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRoomRequest.h"
#import "NetRoomList.h"
#import "SRRefreshView.h"

@class GridBottomView;
@interface RoomGridView : UIView <NetRoomRequestDelegate, SRRefreshDelegate>
{
    __weak IBOutlet UILabel     *_noLocationLabel;
    
    __weak IBOutlet UIButton    *_roomTypeBtn;
    RoomType                    _roomType;
    NSArray                     *_roomTypes;
    
    __weak IBOutlet UIButton    *_rangeBtn;
    CGFloat                     _range;
    NSArray                     *_ranges;
    
    SRRefreshView               *_refreshView;
    GridBottomView              *_bottomView;
}

@property (strong, nonatomic) NetRoomList           *roomList;
@property (weak, nonatomic) IBOutlet UITableView    *roomsTableView;

- (void) refreshGrid;

- (IBAction)roomTypeSelected:(id)sender;
- (IBAction)distanceSelected:(id)sender;

@end
