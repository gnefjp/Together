//
//  RoomGetJoinPersonsRequest.h
//  Together
//
//  Created by Gnef_jp on 13-5-15.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRoomRequest.h"

@interface RoomGetJoinPersonsRequest : NetRoomRequest

@property (copy,   nonatomic) NSString      *roomID;

@property (copy,   nonatomic) NSString      *sid;

@property (assign, nonatomic) NSInteger     pageSize;
@property (assign, nonatomic) NSInteger     pageNum;

@end
