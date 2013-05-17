//
//  NetUserList.m
//  Together
//
//  Created by APPLE on 13-5-17.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetUserList.h"
#import "GEMTUserInfo.h"
@implementation NetUserList

- (NSArray *) _decodeData:(HTTPResponse *)response
{
    self.isFinish = response.roomListResponse.roomList.isEnd;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    int count = response.userRoomListResponse.userRoomList.userInfoList.count;
    for (int i = 0; i < count; i++)
    {
        User_Info *roomInfo = [response.userRoomListResponse.userRoomList.userInfoList objectAtIndex:i];
        GEMTUserInfo *item = [[GEMTUserInfo alloc] init];
        [item setUserInfoWithLoginResPonse:roomInfo];
        [array addObject:item];
    }
    
    return array;
}

@end
