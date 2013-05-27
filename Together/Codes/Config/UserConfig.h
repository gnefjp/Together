//
//  UserConfig.h
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#ifndef Together_UserConfig_h
#define Together_UserConfig_h

#define kDefaultUserAvatar                  @"user_default_avatar.png"


#define kNotification_userDidLogin          @"Notification_userDidLogin"
#define kNotification_userDidLoginOut       @"Notification_userDidLoginOut"

#define kNotification_SendUserMsgSuccess    @"Notification_SendUserMsgSuccess"
#define kNotification_SendGroupMsgSuccess   @"Notification_SendGroupMsgSuccess"
#define kNotification_StartRoomSuccess      @"kNotification_StartRoomSuccess"

#define kNotification_JoinRoomSuccess       @"Notification_JoinRoomSuccess"
#define kNotification_QuitRoomSuccess       @"Notification_QuitRoomSuccess"

typedef enum
{
    UserGenderType_Unknow   = 0,
    
    UserGenderType_Boy      = 1,
    UserGenderType_Girl     = 2,
    
    UserGenderTyp_Max       = 3,
} UserGenderType;


typedef enum
{
    UserRelationType_NoRelation     = 0,
    UserRelationType_Follow         = 1,
    UserRelationType_Fans           = 2,
    UserRelationType_FollowEach     = 3,
    
    UserRelationType_Own            = 4,
    
    UserRelationType_Max            = 5,
} UserRelationType;

#endif
