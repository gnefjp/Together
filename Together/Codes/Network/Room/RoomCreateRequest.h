//
//  RoomCreateRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRoomRequest.h"

@interface RoomCreateRequest : NetRoomRequest

@property (copy,   nonatomic) NSString          *title;
@property (assign, nonatomic) RoomType          roomType;

@property (copy,   nonatomic) NSString          *address;
@property (copy,   nonatomic) NSString          *addressRemark;
@property (assign, nonatomic) NSInteger         personNumLimit;
@property (assign, nonatomic) UserGenderType    genderType;
@property (copy,   nonatomic) NSString          *beginTime;
@property (copy,   nonatomic) NSString          *endTime;

@property (copy,   nonatomic) NSString          *recordID;
@property (copy,   nonatomic) NSString          *previewID;

@property (copy,   nonatomic) NSString          *roomOwnerID;
@property (copy,   nonatomic) NSString          *roomOwnerNickname;

@end
