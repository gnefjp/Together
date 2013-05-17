//
//  NetMessageList.m
//  Together
//
//  Created by Gnef_jp on 13-5-17.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "MessageData.pb.h"

#import "NetMessageList.h"

#pragma mark- Item
@implementation NetMessageItem

- (NetItem *) initWithMessage:(PBGeneratedMessage *)message
{
    self = [super init];
    if (self)
    {
        if ([message isKindOfClass:[Message_Info class]])
        {
            Message_Info *messageInfo = (Message_Info *)message;
            
//            self.ID = messageInfo.id;
            self.messageType = messageInfo.type;
            
            self.content = messageInfo.content;
            self.sendTime = messageInfo.time;
            
            self.senderID = [NSString stringWithInt:messageInfo.senderId];
//            self.senderNickname = messageInfo.
//            self.senderAvatarID = messageInfo.
            
            self.receiverID = [NSString stringWithInt:messageInfo.recipientId];
            
        }
    }
    return self;
}



- (void) refreshItem:(NetItem*)newItem
{
    if (newItem != nil && self != newItem &&
        [newItem isKindOfClass:[self class]])
    {
        NetMessageItem *newMessage = (NetMessageItem *)newItem;
        self.messageType = newMessage.messageType;
        
        self.content = newMessage.content;
        self.sendTime = newMessage.sendTime;
        
        self.senderID = newMessage.senderID;
        self.senderNickname = newMessage.senderNickname;
        self.senderAvatarID = newMessage.senderAvatarID;
        
        self.receiverID = newMessage.receiverID;
    }
}

@end


#pragma mark- List
@implementation NetMessageList

- (NSArray *) _decodeData:(HTTPResponse *)response
{
//    self.isFinish = response.roomListResponse.roomList.isEnd;
//    
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    
//    int count = response.roomListResponse.roomList.roomInfoListList.count;
//    for (int i = 0; i < count; i++)
//    {
//        RoomInfo *roomInfo = [response.roomListResponse.roomList roomInfoListAtIndex:i];
//        NetRoomItem *item = (NetRoomItem *)[NetRoomItem itemWithMessage:roomInfo];
//        
//        [array addObject:item];
//    }
//    
//    return array;
    
    return nil;
}

@end
