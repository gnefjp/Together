//
//  NetRoomList.m
//  Together
//
//  Created by Gnef_jp on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "RoomData.pb.h"

#import "AppSetting.h"
#import "NetRoomList.h"
#import "GEMTUserManager.h"

#pragma mark- AddressItem
@implementation NetAddressItem

- (NSString *) formatDistance
{
    if (_distance < 0.0001)
    {
        _distance = [_location distanceFromLocation:[AppSetting defaultSetting].currentLocation];
    }
    
    typedef struct
    {
        CLLocationDistance              distance;
        __unsafe_unretained NSString    *formatDes;
    } DistanceData;
    
    DistanceData formatDistances[] = {
        { 100.0,  @"< 100m" },
        { 300.0,  @"< 300m" },
        { 500.0,  @"< 500m" },
        { 1000.0, @"< 1km"  },
        { 3000.0, @"< 3km"  },
        { 5000.0, @"< 5km"  },
    };
    
    for (int i = 0; i < 6; i++)
    {
        if (_distance < formatDistances[i].distance)
        {
            return formatDistances[i].formatDes;
        }
    }
    
    return @"> 5km";
}

@end


#pragma mark- Item
@implementation NetRoomItem
- (id) init
{
    self = [super init];
    if (self)
    {
        self.address = [[NetAddressItem alloc] init];
    }
    return self;
}


- (RoomState) roomState
{
    // TODO: 根据系统时间和开始时间判断
    return RoomState_Waiting;
}


- (NetItem *) initWithMessage:(PBGeneratedMessage *)message
{
    self = [super init];
    if (self)
    {
        if ([message isKindOfClass:[RoomInfo class]])
        {
            RoomInfo* roomInfo = (RoomInfo *)message;
            self.ID = [NSString stringWithInt:roomInfo.roomId];
            self.roomTitle = roomInfo.title;
            self.roomType = roomInfo.type;
            self.perviewID = [NSString stringWithInt:roomInfo.picId];
            
            self.beginTime = roomInfo.beginTime;
            self.createTime = roomInfo.createTime;
            
            self.genderLimitType = roomInfo.genderType;
            self.personLimitNum = roomInfo.limitPersonCount;
            self.joinPersonNum = roomInfo.joinPersonCount;
            
            self.address = [[NetAddressItem alloc] init];
            self.address.location = [[CLLocation alloc] initWithLatitude:roomInfo.address.latitude
                                                               longitude:roomInfo.address.longitude];
            self.address.detailAddr = roomInfo.address.detailAddr;
            self.address.addrRemark = roomInfo.address.addrRemark;
            self.address.distance = roomInfo.distance * 1000.0;
            
            self.ownerID = [NSString stringWithInt:roomInfo.ownerId];
            self.ownerNickname = roomInfo.ownerNickname;
            
            if ([self.ownerID isEqualToString:[[GEMTUserManager defaultManager].userInfo.userId stringValue]])
            {
                self.relationWitMe = RoomRelationType_MyRoom;
            }
        }
    }
    return self;
}


- (void) refreshItem:(NetItem *)newItem
{
    if ([newItem isKindOfClass:[self class]] && newItem != self)
    {
        NetRoomItem* roomItem = (NetRoomItem *)newItem;
        self.roomTitle = roomItem.roomTitle;
        self.roomType = roomItem.roomType;
        self.perviewID = roomItem.perviewID;
        
        self.beginTime = roomItem.beginTime;
        
        self.genderLimitType = roomItem.genderLimitType;
        self.personLimitNum = roomItem.personLimitNum;
        self.joinPersonNum = roomItem.joinPersonNum;
        
        self.address = self.address;
        
        self.ownerID = roomItem.ownerID;
        self.ownerNickname = roomItem.ownerNickname;
    }
}

@end


#pragma mark- List
@implementation NetRoomList

- (NSArray *) _decodeData:(HTTPResponse *)response
{
    self.isFinish = response.roomListResponse.roomList.isEnd;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    int count = response.roomListResponse.roomList.roomInfoListList.count;
    for (int i = 0; i < count; i++)
    {
        RoomInfo *roomInfo = [response.roomListResponse.roomList roomInfoListAtIndex:i];
        NetRoomItem *item = (NetRoomItem *)[NetRoomItem itemWithMessage:roomInfo];
        
        [array addObject:item];
    }
    
    return array;
}

@end
