//
//  RoomGetListRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRoomRequest.h"

@interface RoomGetListRequest : NetRoomRequest

@property (assign, nonatomic) RoomType                  roomType;
@property (assign, nonatomic) CGFloat                   range;

@property (assign, nonatomic) CLLocationCoordinate2D    location;

@property (assign, nonatomic) NSInteger                 pageSize;
@property (assign, nonatomic) NSInteger                 pageNum;

@end
