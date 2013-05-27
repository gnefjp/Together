//
//  NetRoomManager.h
//  Together
//
//  Created by Gnef_jp on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRoomList.h"

@interface NetRoomManager : NSObject

@property (strong, nonatomic) NetRoomList   *roomList;

+ (NetRoomManager *) defaultManager;

@end
