//
//  RoomCreateRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRoomRequest.h"

@interface RoomCreateRequest : NetRoomRequest

@property (copy,   nonatomic) NSString          *roomTitle;
@property (assign, nonatomic) RoomType          roomType;

@property (assign, nonatomic) double            longitude;
@property (assign, nonatomic) double            latitude;
@property (copy,   nonatomic) NSString          *detailAddr;
@property (copy,   nonatomic) NSString          *addrRemark;

@property (assign, nonatomic) NSInteger         personNumLimit;
@property (assign, nonatomic) UserGenderType    genderType;

@property (copy,   nonatomic) NSString          *beginTime;

@property (copy,   nonatomic) NSString          *recordID;
@property (copy,   nonatomic) NSString          *previewID;

@property (copy,   nonatomic) NSString          *sid;
@property (copy,   nonatomic) NSString          *ownerID;
@property (copy,   nonatomic) NSString          *ownerNickname;

@end
