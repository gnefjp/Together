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
    RoomType_BRPG           = 0, // 桌游（board role-playing games）
    RoomType_Catering       = 1, // 餐饮
    RoomType_Sports         = 2, // 运动
    RoomType_Shopping       = 3, // 购物
    RoomType_Movie          = 4, // 电影
    
    RoomType_Max            = 5,
} RoomType;


typedef enum
{
    RoomState_Waiting   = 0,
    RoomState_Playing   = 1,
    RoomState_Ended     = 2,
    
    RoomState_Max       = 3,
} RoomState;


#define kNotification_InitCurrentLocation   @"Notification_InitCurrentLocation"

#endif
