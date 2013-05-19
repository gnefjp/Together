//
//  MessageGetChatListRequest.h
//  Together
//
//  Created by Gnef_jp on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetMessageRequest.h"

typedef enum
{
    GetMessageType_Group    = 1,
    GetMessageType_Single   = 2,
    
    GetMessageType_Max      = 3,
} GetMessageType;


@interface MessageGetChatListRequest : NetMessageRequest

@property (copy,   nonatomic) NSString          *currentID;

@property (assign, nonatomic) NSInteger         msgNum;
@property (copy,   nonatomic) NSString          *recipientID;
@property (copy,   nonatomic) NSString          *roomID;

@property (assign, nonatomic) GetMessageType    getMessagetType;
@property (assign, nonatomic) GetListDirect     getListDirect;

@end
