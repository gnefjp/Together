//
//  KeepSorcket.h
//  Together
//
//  Created by APPLE on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"


@interface KeepSorcket : NSObject
{
    GCDAsyncSocket                                 *socket;
    int                                             count;
}

+ (KeepSorcket*)defaultManager;
- (void)connectToHost;

//消息发送 msgType 1.群聊 2.私聊
- (void) sendMsgWithSenderId:(NSString*)senderId
                    receipId:(NSString*)receipientId
                      roomId:(NSString*)roomId
                     msgType:(int)type
                     content:(NSString*)content;

//房间
- (void) startRoomWithRoomID:(NSString*)roomID;

- (void) joinRoomWithRoomID:(NSString *)roomID;
- (void) quitRoomWithRoomID:(NSString *)roomID;

@end
