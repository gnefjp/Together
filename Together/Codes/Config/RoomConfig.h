//
//  RoomConfig.h
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#ifndef Together_RoomConfig_h
#define Together_RoomConfig_h

typedef enum
{
    RoomType_All            = 0, 
    RoomType_BRPG           = 1, // 桌游（board role-playing games）
    RoomType_Catering       = 2, // 餐饮
    RoomType_Sports         = 3, // 运动
    RoomType_Shopping       = 4, // 购物
    RoomType_Movie          = 5, // 电影
    
    RoomType_Max            = 6,
} RoomType;


typedef enum
{
    RoomState_Waiting   = 1,
    RoomState_Ended     = 2,
    
    RoomState_Max       = 1,
} RoomState;

#define kDefaultRoomPreview                 @"room_default_preview.png"

#define kNotification_InitCurrentLocation   @"Notification_InitCurrentLocation"

#endif
