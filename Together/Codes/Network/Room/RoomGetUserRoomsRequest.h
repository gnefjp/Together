//
//  RoomGetUserRommsRequest.h
//  Together
//
//  Created by Gnef_jp on 13-5-15.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRoomRequest.h"

@interface RoomGetUserRoomsRequest : NetRoomRequest

@property (copy,   nonatomic) NSString          *sid;
@property (assign, nonatomic) RoomState         roomStatus;
@property (assign, nonatomic) BOOL              isMyRoom;

@property (assign, nonatomic) NSInteger         pageNum;
@property (assign, nonatomic) NSInteger         pageSize;

@end
