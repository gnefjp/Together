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
            
            self.ID = [NSString stringWithInt:messageInfo.messageId];
            self.messageType = MessageType_Text; // messageInfo.type;
            
            self.content = messageInfo.content;
            self.sendTime = messageInfo.time;
            
            self.senderID = [NSString stringWithInt:messageInfo.senderId];
            self.receiverID = [NSString stringWithInt:messageInfo.recipientId];
            
        }
    }
    return self;
}


- (NetMessageItem *) initWithMessageResponse:(UserMessageResponse *)response
{
    self = [self initWithMessage:response.messageInfo];
    if (self)
    {
        self.senderID = [NSString stringWithInt:response.sender.uid];
        self.senderAvatarID = [NSString stringWithInt:response.sender.picId];
        self.senderNickname = response.sender.nickName;
        
        self.receiverID = [NSString stringWithInt:response.recipient.uid];
        
        self.unreadNum = response.messageCount;
    }
    return self;
}

@end


#pragma mark- List
@implementation NetMessageList

- (NSArray *) _decodeData:(HTTPResponse *)response
{
    // 清除本地的数据
    for (int i = 0; i < _list.count; i ++)
    {
        NetMessageItem *item = [_list objectAtIndex:i];
        if ([item.ID hasPrefix:@"local_"])
        {
            [self removeItemById:item.ID];
            i --;
        }
    }
    
    self.isFinish = response.list.isEnd;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    int count = response.list.userMessageInfoList.count;
    for (int i = 0; i < count; i++)
    {
        UserMessageResponse *messageResponse = [response.list.userMessageInfoList objectAtIndex:i];
        NetMessageItem *item = [[NetMessageItem alloc] initWithMessageResponse:messageResponse];
        [array addObject:item];
    }
    
    return array;
}


- (void) addItemList:(HTTPResponse *)response direct:(GetListDirect)direct
{
    NSArray *tmpList = [self _decodeData:response];
    
    if (tmpList != nil)
    {
        if (direct == GetListDirect_Last)
        {
            [_list removeAllObjects];
            [_dict removeAllObjects];
        }
        
        BOOL isAdd = (direct == GetListDirect_Last ||  direct == GetListDirect_Before);
        
        for (int idx = 0, len = [tmpList count]; idx < len; idx++)
        {
            NetItem* item = (NetItem*) [tmpList objectAtIndex:idx];
            
            if ([_dict objectForKey:item.ID] == nil)
            {
                if (isAdd)
                {
                    [_list addObject:item];
                }
                else
                {
                    [_list insertObject:item atIndex:0];
                }
                
                [_dict setObject:item forKey:item.ID];
            }
        }
    }
}

@end
