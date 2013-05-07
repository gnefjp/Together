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
            
            self.genderLimitType = roomInfo.genderType;
            self.personLimitNum = roomInfo.limitPersonCount;
            self.joinPersonNum = roomInfo.joinPersonCount;
            
            self.address.location = [[CLLocation alloc] initWithLatitude:roomInfo.address.latitude
                                                               longitude:roomInfo.address.longitude];
            self.address.detailAddr = roomInfo.address.detailAddr;
            self.address.addrRemark = roomInfo.address.addrRemark;
            self.address.distance = roomInfo.distance;
            
            self.ownerID = [NSString stringWithInt:roomInfo.ownerId];
            self.ownerNickname = roomInfo.ownerNickname;
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
//    self.isFinish = response.
    return nil;
}

@end
