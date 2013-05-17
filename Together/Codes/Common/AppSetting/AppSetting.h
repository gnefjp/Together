//
//  AppSetting.h
//  Together
//
//  Created by Gnef_jp on 13-5-7.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

@interface AppSetting : NSObject

+ (AppSetting *) defaultSetting;

@property (strong, nonatomic) CLLocation        *currentLocation;

//@property (assign, nonatomic) NetUserItem   *userItem; TODO: 老大加一下用户信息

@property (strong, nonatomic) NSString          *serverCurrentTime;

@end
