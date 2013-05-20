//
//  MessageConfig.h
//  Together
//
//  Created by Gnef_jp on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#ifndef Together_MessageConfig_h
#define Together_MessageConfig_h


typedef enum
{
    GetListDirect_Last      = -1,
    
    GetListDirect_Before    = 0,
    GetListDirect_Later     = 1,
    
    GetListDirect_Max       = 2,
} GetListDirect;


typedef enum
{
    GetMessageType_Group    = 1,
    GetMessageType_Single   = 2,
    
    GetMessageType_Max      = 3,
} GetMessageType;

#endif
