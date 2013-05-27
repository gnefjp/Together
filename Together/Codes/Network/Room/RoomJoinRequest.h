//
//  RoomJoinRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRoomRequest.h"

@interface RoomJoinRequest : NetRoomRequest

@property (copy, nonatomic) NSString    *roomID;

@property (copy, nonatomic) NSString    *userID;
@property (copy, nonatomic) NSString    *sid;

@end
