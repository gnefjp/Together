//
//  KeepSorcket.m
//  Together
//
//  Created by APPLE on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "KeepSorcket.h"
#import "GEMTUserManager.h"

static KeepSorcket *instance;
@implementation KeepSorcket

+ (KeepSorcket*)defaultManager
{
    @synchronized(self)
    {
        if (!instance)
        {
            instance = [[KeepSorcket alloc] init];
        }
    }
    return instance;
}

- (NSString*) _getLoginUrlString
{
    return [NSString stringWithFormat:@"action=301&userId=%@",[GEMTUserManager defaultManager].userInfo.userId];
}

- (void) sendMsgWithSenderId:(NSString*)senderId
                            receipId:(NSString*)receipientId
                              roomId:(NSString*)roomId
                             msgType:(int)type
                             content:(NSString*)content
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"302" forKey:@"action"];
    [dic setValue:senderId forKey:@"senderId"];
    [dic setValue:receipientId forKey:@"recipientId"];
    [dic setValue:roomId forKey:@"roomId"];
    [dic setValue:[NSString stringWithInt:type] forKey:@"msgType"];
    [dic setValue:content forKey:@"content"];
    [self _sendInfoWithPostString:[NSString urlArgsStringFromDictionary:dic]];
}


- (void) _sendRoomMsgWithID:(NSString *)roomID action:(NSString *)action
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:action forKey:@"action"];
    [dic setValue:[GEMTUserManager defaultManager].sId forKey:@"sid"];
    [dic setValue:roomID forKey:@"roomId"];
    [self _sendInfoWithPostString:[NSString urlArgsStringFromDictionary:dic]];
}


- (void) startRoomWithRoomID:(NSString*)roomID
{
    [self _sendRoomMsgWithID:roomID action:@"303"];
}


- (void) joinRoomWithRoomID:(NSString *)roomID
{
    [self _sendRoomMsgWithID:roomID action:@"304"];
}


- (void) quitRoomWithRoomID:(NSString *)roomID
{
    [self _sendRoomMsgWithID:roomID action:@"305"];
}


//群聊
//@"action=302&senderId=2&recipientId=-1&roomId=1001&msgType=1&content=123";
//[self sendInfoWithPostString:str];

//私聊
//@"action=302&senderId=2&recipientId=1&roomId=-1&msgType=2&content=456";

//开始房间
// NSString *str = @"action=303&sid=ce37faf0cc0b15d9d627148a64fcb29d&roomId=1001";



- (void)_sendInfoWithPostString:(NSString*)str
{
    [socket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [socket readDataWithTimeout:-1 tag:0];

}

- (void)connectToHost
{
    if (![GEMTUserManager defaultManager].sId)
    {
        return;
    }
    
    socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    if(![socket connectToHost:kServerAddr onPort:[kKeepPort intValue] error:nil])
    {
        NSLog(@"connect failed");
    }else
    {
        NSLog(@"connect ok");
        
        [socket writeData:[[self _getLoginUrlString] dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
        [socket readDataWithTimeout:-1 tag:0];
    }
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *newMessage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [socket readDataWithTimeout:-1 tag:0];
    if ([newMessage length] != 0)
    {
        switch ([newMessage intValue])
        {
            case BIND_USER_CHAT_SUCCESS:
            {  
//                [self sendInfoWithPostString:str];
            }
                break;
            case BIND_USER_CHAT_USER_NOTEXIST:
                break;
            case SAVE_MSG_SINGLE_SUCCESS:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_SendUserMsgSuccess object:nil];
            }
                break;
            case SAVE_MSG_GROUP_SUCCESS:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_SendGroupMsgSuccess object:nil];
            }
                break;
            case SAVE_MSG_SENDER_NOTEXIST:
                break;
            case SAVE_MSG_ROOM_NOTEXIST:
                break;
            case SAVE_MSG_RECIPIENT_NOTEXIST:
                break;
            case SAVE_MSG_MSGTYPE_ERROR:
                break;
            case START_ROOM_SUCCESS:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_StartRoomSuccess
                                                                    object:nil];
            }
                break;
            case START_ROOM_ISNOT_OWNER:
                break;
            case START_ROOM_HASSTARTED_OR_NOTEXIST:
                break;
            case LC_JOIN_ROOM_SUCCESS:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_JoinRoomSuccess
                                                                    object:nil];
                break;
            }
            case LC_QUIT_ROOM_SUCCESS:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_QuitRoomSuccess
                                                                    object:nil];
                break;
            }
            default:
                break;
        }
    }

}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    count++;
    if (count<=10) {
        [self connectToHost];
    }
}
@end

