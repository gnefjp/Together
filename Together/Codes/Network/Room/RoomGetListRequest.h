//
//  RoomGetListRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRoomRequest.h"

@interface RoomGetListRequest : NetRoomRequest

@property (copy,   nonatomic) NSString                  *userID;

@property (assign, nonatomic) RoomType                  roomType;
@property (assign, nonatomic) NSInteger                 range;

@property (assign, nonatomic) CLLocationCoordinate2D    location;

@property (assign, nonatomic) NSInteger                 pageSize;
@property (assign, nonatomic) NSInteger                 pageNum;

@end
