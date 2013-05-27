//
//  UserRoomsView.h
//  Together
//
//  Created by Gnef_jp on 13-5-19.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRoomRequest.h"
#import "NetRoomList.h"
#import "SRRefreshView.h"

@class UserRoomsView;
@protocol UserRoomViewDelegate <NSObject>
- (void) UserRoomsViewWantBack:(UserRoomsView *)userRoomsView;
- (void) UserRoomsViewWantShowNavigation:(UserRoomsView *)userRoomsView;
@end



@class GridBottomView;
@interface UserRoomsView : UIView <NetRoomRequestDelegate, SRRefreshDelegate>
{
    __weak id <UserRoomViewDelegate>        _delegate;
    __weak IBOutlet UIButton                *_menuBtn;
    __weak IBOutlet UIButton                *_backBtn;
    
    NSArray                                 *_roomBelongsTypes;
    BOOL                                    _isMyRoom;
    NSArray                                 *_roomStates;
    RoomState                               _roomState;
    
    SRRefreshView                           *_refreshView;
    GridBottomView                          *_bottomView;
}

@property (strong, nonatomic) NetRoomList           *roomList;

@property (weak,   nonatomic) id                    delegate;
@property (assign, nonatomic) BOOL                  isShowBackBtn;

@property (strong, nonatomic) NSString              *userId;
@property (strong, nonatomic) NSString              *nickname;
@property (weak,   nonatomic) IBOutlet UILabel      *nicknameLabel;

@property (weak, nonatomic) IBOutlet UITableView    *roomsTableView;

+ (UserRoomsView *) userRoomViewWithUserId:(NSString *)userId
                                  nickname:(NSString *)nickname
                             isShowBackBtn:(BOOL)isShowBackBtn
                                  delegate:(id)delegate;

- (void) refreshGrid;

- (IBAction)roomBelongSelected:(id)sender;
- (IBAction)roomStateSelected:(id)sender;

- (IBAction)menuDidPressed:(id)sender;
- (IBAction)backDidPressed:(id)sender;
@end
