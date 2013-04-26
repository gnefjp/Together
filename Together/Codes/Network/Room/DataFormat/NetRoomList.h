//
//  NetRoomList.h
//  Together
//
//  Created by Gnef_jp on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetItemList.h"


#pragma mark- Item
@interface NetRoomItem : NetItem

@property (copy,   nonatomic) NSString          *roomTitle;
@property (assign, nonatomic) RoomType          roomType;
@property (copy,   nonatomic) NSString          *perviewUrl;

@property (copy,   nonatomic) NSString          *beginTime;
@property (assign, nonatomic) RoomState         roomState;

@property (assign, nonatomic) UserGenderType    genderLimitType;
@property (assign, nonatomic) NSInteger         personLimitNum;
@property (assign, nonatomic) NSInteger         joinPersonNum;

@property (copy,   nonatomic) NSString          *address;
@property (copy,   nonatomic) NSString          *addressDes;

@property (assign, nonatomic) double            distance;

@property (copy,   nonatomic) NSString          *ownerID;
@property (copy,   nonatomic) NSString          *ownerNickname;

@end


#pragma mark- List
@interface NetRoomList : NetItemList



@end
