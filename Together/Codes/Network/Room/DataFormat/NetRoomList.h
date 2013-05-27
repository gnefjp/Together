//
//  NetRoomList.h
//  Together
//
//  Created by Gnef_jp on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetItemList.h"

#pragma mark- AddressItem
@interface NetAddressItem : NetItem

@property (strong, nonatomic) CLLocation            *location;

@property (readonly,nonatomic)NSString              *formatDistance;
@property (assign, nonatomic) CLLocationDistance    distance;
@property (copy,   nonatomic) NSString              *detailAddr;
@property (copy,   nonatomic) NSString              *addrRemark;

@end


typedef enum
{
    RoomRelationType_NoRelation = 0,
    RoomRelationType_Joined     = 1,
    RoomRelationType_MyRoom     = 2,
    
    RoomRelationType_Max        = 3,
} RoomRelationType;


#pragma mark- Item
@interface NetRoomItem : NetItem

@property (copy,   nonatomic) NSString          *roomTitle;
@property (assign, nonatomic) RoomType          roomType;
@property (copy,   nonatomic) NSString          *perviewID;
@property (copy,   nonatomic) NSString          *recordID;

@property (copy,   nonatomic) NSString          *createTime;
@property (copy,   nonatomic) NSString          *beginTime;
@property (assign, nonatomic) RoomState         roomState;

@property (assign, nonatomic) UserGenderType    genderLimitType;
@property (assign, nonatomic) NSInteger         personLimitNum;
@property (assign, nonatomic) NSInteger         joinPersonNum;

@property (strong, nonatomic) NetAddressItem    *address;

@property (assign, nonatomic) RoomRelationType  relationWitMe;

@property (copy,   nonatomic) NSString          *ownerID;
@property (copy,   nonatomic) NSString          *ownerNickname;
@property (assign, nonatomic) UserRelationType  ownerRelationWithMe;

@end


#pragma mark- List
@interface NetRoomList : NetItemList



@end
