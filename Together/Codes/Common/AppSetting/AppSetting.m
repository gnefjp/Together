//
//  AppSetting.m
//  Together
//
//  Created by Gnef_jp on 13-5-7.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "AppSetting.h"

@implementation AppSetting

static AppSetting   *s_defaultSetting = nil;

+ (AppSetting *) defaultSetting
{
    if (s_defaultSetting == nil)
    {
        @synchronized(self)
        {
            if (s_defaultSetting == nil)
            {
                s_defaultSetting = [[self alloc] init];
            }
        }
    }
    
    return s_defaultSetting;
}

@end
