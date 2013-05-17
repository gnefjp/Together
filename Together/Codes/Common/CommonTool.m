//
//  CommonTool.m
//  Together
//
//  Created by Gnef_jp on 13-5-10.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "NetFileManager.h"

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