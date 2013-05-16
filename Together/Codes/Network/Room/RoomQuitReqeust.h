//
//  RoomQuitReqeust.h
//  Together
//
//  Created by Gnef_jp on 13-5-15.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRoomRequest.h"

@interface RoomQuitReqeust : NetRoomRequest

@property (copy, nonatomic) NSString    *roomID;

@property (copy, nonatomic) NSString    *userID;
@property (copy, nonatomic) NSString    *sid;

@end
