//
//  RoomShowInfoRequest.h
//  Together
//
//  Created by Gnef_jp on 13-5-15.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRoomRequest.h"

@interface RoomShowInfoRequest : NetRoomRequest

@property (copy, nonatomic) NSString    *roomID;
@property (copy, nonatomic) NSString    *sid;
@property (copy, nonatomic) NSString    *userID;

@end
