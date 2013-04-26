//
//  NetRoomList.m
//  Together
//
//  Created by Gnef_jp on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "RoomData.pb.h"

#import "NetRoomList.h"

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
//            self.ID = roomInfo
            self.roomTitle = roomInfo.title;
            self.roomType = roomInfo.type;
            self.perviewUrl = roomInfo.picUrl;
            
            self.beginTime = roomInfo.beginTime;
            
            self.genderLimitType = roomInfo.genderType;
            self.personLimitNum = roomInfo.limitPersonCount;
            self.joinPersonNum = roomInfo.joinPersonCount;
            
            self.detailAddr = roomInfo.address;
            self.addrRemark = roomInfo.addrRemarks;
            
            self.distance = roomInfo.distance;
            
//            self.ownerID = roomInfo
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
        self.perviewUrl = roomItem.perviewUrl;
        
        self.beginTime = roomItem.beginTime;
        
        self.genderLimitType = roomItem.genderLimitType;
        self.personLimitNum = roomItem.personLimitNum;
        self.joinPersonNum = roomItem.joinPersonNum;
        
        self.longitude = roomItem.longitude;
        self.latitude = roomItem.latitude;
        self.detailAddr = roomItem.detailAddr;
        self.addrRemark = roomItem.addrRemark;
        
        self.distance = roomItem.distance;
        
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
