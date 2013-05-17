//
//  UserConfig.h
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#ifndef Together_UserConfig_h
#define Together_UserConfig_h

#define kUserDefaultAvatar                  @"user_default_avatar.png"

#define kNotification_userDidLogin          @"Notification_userDidLogin"
#define kNotification_userDidLoginOut       @"Notification_userDidLoginOut"


typedef enum
{
    UserGenderType_Unknow   = 0,
    
    UserGenderType_Boy      = 1,
    UserGenderType_Girl     = 2,
    
    UserGenderTyp_Max       = 3,
} UserGenderType;

#endif
