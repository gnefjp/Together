//
//  NetUserList.m
//  Together
//
//  Created by APPLE on 13-5-17.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "UserData.pb.h"

#import "NetUserList.h"

#pragma mark- Item
@implementation NetUserItem

- (NetItem *) initWithMessage:(PBGeneratedMessage *)message
{
    self = [super init];
    if (self)
    {
        if ([message isKindOfClass:[User_Info class]])
        {
            User_Info *userInfo = (User_Info *)message;
            
            self.ID = [NSString stringWithInt:userInfo.uid];
            self.userName = userInfo.username;
            self.nickName = userInfo.nickName;
            
            self.genderType = userInfo.sex;
            
            self.avataId = [NSString stringWithInt:userInfo.picId];
            
            self.signatureRecordId = [NSString stringWithInt:userInfo.signatureRecordId];
            self.signatureText = userInfo.signatureText;
            
            self.birthday = userInfo.birthday;
            
            self.followedNum = userInfo.followedNum;
            self.followNum = userInfo.followNum;
            
            self.praiseNum = userInfo.praiseNum;
            self.visitNum = userInfo.visitNum;
        }
        
        
        if ([_nickName length] == 0)
        {
            _nickName = @"未知";
        }
        
        if ([_signatureText length] == 0)
        {
            _signatureText = @"这个家伙很懒，什么都没有留下";
        }
    }
    return self;
}


- (int) age
{
    return [_birthday ageUsingDateFormat:@"yyyy-MM-dd"];
}


@end


#pragma mark- List
@implementation NetUserList

- (NSArray *) _decodeData:(HTTPResponse *)response
{
    self.isFinish = response.roomListResponse.roomList.isEnd;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    int count = response.userRoomListResponse.userRoomList.userInfoList.count;
    for (int i = 0; i < count; i++)
    {
        User_Info *roomInfo = [response.userRoomListResponse.userRoomList.userInfoList objectAtIndex:i];
        
        NetUserItem *item = (NetUserItem *)[NetUserItem itemWithMessage:roomInfo];
        [array addObject:item];
    }
    
    return array;
}

@end
