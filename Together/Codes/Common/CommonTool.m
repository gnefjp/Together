//
//  CommonTool.m
//  Together
//
//  Created by Gnef_jp on 13-5-10.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "NetFileManager.h"
#import "AppSetting.h"

#import "CommonTool.h"

@implementation CommonTool

static CommonTool *s_shareCommonTool = nil;

+ (CommonTool *) shareTool
{
    if (s_shareCommonTool == nil)
    {
        @synchronized(self)
        {
            if (s_shareCommonTool == nil)
            {
                s_shareCommonTool = [[self alloc] init];
            }
        }
    }
    
    return s_shareCommonTool;
}

@end



#pragma mark- Extend

#pragma mark- UIImageView
@implementation UIImageView (CommonTool)

- (void) dealloc
{
    [[NetFileManager defaultManager] removeDelegate:self];
}

- (void) setImageWithFileID:(NSString *)imageID
           placeholderImage:(UIImage *)placeholderImage
{
    [[NetFileManager defaultManager] removeDelegate:self];
    UIImage* image = [[NetFileManager defaultManager] imageWithFileID:imageID delegate:self];
    self.image = (image == nil) ? placeholderImage : image;
}


#pragma mark- NetFileManagerDelegate
- (void) NetFileManager:(NetFileManager *)fileManager fileID:(NSString *)fileID image:(UIImage *)image
{
    if (image)
    {
        self.image = image;
    }
}

@end



#pragma mark- UIButton
@implementation UIButton (CommonTool)

- (void) setImageWithName:(NSString *)imageName
{
    NSString *normalName = [NSString stringWithFormat:@"%@_a.png", imageName];
    NSString *highlightedName = [NSString stringWithFormat:@"%@_b.png", imageName];
    
    [self setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:highlightedName] forState:UIControlStateHighlighted];
}


- (void) setBgImageWithName:(NSString *)imageName
{
    NSString *normalName = [NSString stringWithFormat:@"%@_a.png", imageName];
    NSString *highlightedName = [NSString stringWithFormat:@"%@_b.png", imageName];
    
    [self setBackgroundImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:highlightedName] forState:UIControlStateHighlighted];
}

@end


#pragma mark- NSString 
@implementation NSString (CommonTool)


- (NSString *) _isForStartTimeInterval:(BOOL)isForStartTime withTime:(NSTimeInterval)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:self];
    
    NSTimeInterval distance =  time - [date timeIntervalSince1970];
    if (isForStartTime)
    {
        distance = -distance;
    }
    
    typedef struct
    {
        NSInteger                       timeInterval;
        __unsafe_unretained NSString    *msg;
    } ShowInfo;
    
    ShowInfo infos[] = {
        {((NSInteger)distance / 3600),  @"小时"    },
        {((NSInteger)distance / 60),    @"分钟"    },
        {((NSInteger)distance),         @"秒"      },
    };
    
    if ((NSInteger)distance / (24 * 60 * 60) < 1)
    {
        for (int i = 0; i < 3; i++)
        {
            if (infos[i].timeInterval > 0)
            {
                return [NSString stringWithFormat:@"%d %@%@",
                        infos[i].timeInterval, infos[i].msg,
                        (isForStartTime ? @"后开始" : @"前")];
            }
        }
        return (isForStartTime ? @"1秒后开始" : @"1秒前");
    }
    else
    {
        NSInteger day = (NSInteger)distance / (24 * 60 * 60);
        return [NSString stringWithFormat:@"%d 天%@", day, (isForStartTime ? @"后开始" : @"前")];
    }
}


- (NSString *) _isForStartTimeInterval:(BOOL)isForStartTime
{
    NSTimeInterval serverTime = [[AppSetting defaultSetting].serverCurrentTime doubleValue];
    return [self _isForStartTimeInterval:isForStartTime withTime:serverTime];
}


- (NSString *) startTimeIntervalWithServer
{
    return [self _isForStartTimeInterval:YES];
}


- (NSString *) startTimeIntervalWithClient
{
    NSTimeInterval clientTime = [[NSDate date] timeIntervalSince1970];
    return [self _isForStartTimeInterval:YES withTime:clientTime];
}


- (NSString *) timeIntervalWithServer
{
    return [self _isForStartTimeInterval:NO];
}

@end