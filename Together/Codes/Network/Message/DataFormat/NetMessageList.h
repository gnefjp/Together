//
//  NetMessageList.h
//  Together
//
//  Created by Gnef_jp on 13-5-17.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetItemList.h"

typedef enum
{
    MessageType_Text    = 0,
    MessageType_Sound   = 1,
    
    MessageType_Max     = 2,
} MessageType;


#pragma mark- Item
@interface NetMessageItem : NetItem

@property (assign, nonatomic) MessageType   messageType;

@property (copy,   nonatomic) NSString      *content;  // 音频ID或者Text
@property (copy,   nonatomic) NSString      *sendTime; 

@property (copy,   nonatomic) NSString      *senderID;
@property (copy,   nonatomic) NSString      *senderNickname;
@property (copy,   nonatomic) NSString      *senderAvatarID;

@property (copy,   nonatomic) NSString      *receiverID;

@property (assign, nonatomic) NSInteger     unreadNum;

- (NetMessageItem *)initWithMessageResponse:(UserMessageResponse *)response;

@end


#pragma mark- List
@interface NetMessageList : NetItemList

- (void) addItemList:(HTTPResponse *)response direct:(GetListDirect)direct;

@end
