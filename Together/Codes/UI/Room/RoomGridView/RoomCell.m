//
//  RoomCell.m
//  Together
//
//  Created by Gnef_jp on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "CommonTool.h"

#import "AppSetting.h"
#import "NetRoomList.h"

#import "RoomCell.h"

@implementation RoomCell

- (void) _setGenderType
{
    NSString *imageNames[] = {
        @"",
        @"room_gender_limit_boy.png",
        @"room_gender_limit_girl.png",
    };
    
    _genderTypeImageView.image = [UIImage imageNamed:imageNames[_roomItem.genderLimitType]];
}


- (void) setIsNoDistance:(BOOL)isNoDistance
{
    _distanceLabel.hidden = isNoDistance;
}


- (void) setRoomItem:(NetRoomItem *)roomItem
{
    if (_roomItem != roomItem)
    {
        _roomItem = roomItem;
    }
    
    _roomTitleLabel.text = _roomItem.roomTitle;
    _beginTimeLabel.text = [_roomItem.beginTime startTimeIntervalWithServer];
    _addrTitleLabel.text = _roomItem.address.detailAddr;
    _distanceLabel.text = _roomItem.address.formatDistance;
    _ownNicknameLabel.text = _roomItem.ownerNickname;
    
    if (_roomItem.personLimitNum < 1)
    {
        _joinPersonNum.text = [NSString stringWithFormat:@"%d 人/ 不限", _roomItem.joinPersonNum];
    }
    else
    {
        _joinPersonNum.text = [NSString stringWithFormat:@"%d 人/ %d 人",
                               _roomItem.joinPersonNum,
                               _roomItem.personLimitNum];
    }
    
    [self _setGenderType];
}

@end
