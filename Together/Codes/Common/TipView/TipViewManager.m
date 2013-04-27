//
//  TipViewManager.m
//  MaxDoodle
//
//  Created by Gnef_jp on 13-4-1.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "TipViewManager.h"

@interface TipViewInfo : NSObject

@property (strong, nonatomic) NSString          *ID;
@property (strong, nonatomic) MBProgressHUD     *progressHUD;

@end

@implementation TipViewInfo

@end
//////////////////////////////////////////////////////////////////////////////////////////



@implementation TipViewManager

static TipViewManager*   s_defaultManager = nil;

+ (TipViewManager*) defaultManager
{
    if (s_defaultManager == nil)
    {
        @synchronized(self)
        {
            if (s_defaultManager == nil)
            {
                s_defaultManager = [[self alloc] init];
            }
        }
    }
    
    return s_defaultManager;
}


- (id) init
{
    self = [super init];
    if (self)
    {
        _tipViewList = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void) _clearAllTipView
{
    for (TipViewInfo* viewInfo in _tipViewList)
    {
        viewInfo.progressHUD.delegate = nil;
        [viewInfo.progressHUD removeFromSuperview];
    }
    [_tipViewList removeAllObjects];
}


- (void) removeTipWithID:(id)ID
{
    NSString* idStr = [NSString stringWithFormat:@"%p", ID];
    
    TipViewInfo* viewInfo = [self _tipViewInfoWithID:idStr];
    viewInfo.progressHUD.delegate = nil;
    [viewInfo.progressHUD removeFromSuperview];
    [_tipViewList removeObject:viewInfo];
}


- (MBProgressHUD*) progressHUDWithID:(id)ID
{
    NSString* idStr = [NSString stringWithFormat:@"%p", ID];
    
    return [self _tipViewInfoWithID:idStr].progressHUD;
}


- (TipViewInfo*) _tipViewInfoWithID:(NSString*)ID
{
    for (TipViewInfo* viewInfo in _tipViewList)
    {
        if ([viewInfo.ID isEqualToString:ID])
        {
            return viewInfo;
        }
    }
    
    return nil;
}


- (TipViewInfo*) _tipViewInfoWithProgressHUD:(id)progressHUD
{
    for (TipViewInfo* viewInfo in _tipViewList)
    {
        if (viewInfo.progressHUD == progressHUD)
        {
            return viewInfo;
        }
    }
    return nil;
}


- (MBProgressHUD *) showTipText:(NSString*)tipText
                      imageName:(NSString*)imageName
                         inView:(UIView*)inView
                             ID:(id)ID
{
    NSString* idStr = [NSString stringWithFormat:@"%p", ID];
    
    TipViewInfo* oldTipViewInfo = [self _tipViewInfoWithID:idStr];
    if (oldTipViewInfo != nil)
    {
        oldTipViewInfo.progressHUD.delegate = nil;
        [oldTipViewInfo.progressHUD removeFromSuperview];
        [_tipViewList removeObject:oldTipViewInfo];
    }
    
    TipViewInfo* tipViewInfo = [[TipViewInfo alloc] init];
    tipViewInfo.ID = idStr;
    tipViewInfo.progressHUD = [[MBProgressHUD alloc] initWithView:inView];
    tipViewInfo.progressHUD.delegate = self;
    [inView addSubview:tipViewInfo.progressHUD];
    
    if ([imageName length] > 0)
    {
        tipViewInfo.progressHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    }
    tipViewInfo.progressHUD.labelText = tipText;
    tipViewInfo.progressHUD.mode = MBProgressHUDModeCustomView;
    
    [tipViewInfo.progressHUD show:YES];
    [_tipViewList addObject:tipViewInfo];
    
    return tipViewInfo.progressHUD;
}


- (void) hideTipWithID:(id)ID animation:(BOOL)animation
{
    NSString* idStr = [NSString stringWithFormat:@"%p", ID];
    
    [[self _tipViewInfoWithID:idStr].progressHUD hide:animation];
}


- (void) hideTipWithID:(id)ID animation:(BOOL)animation delay:(NSTimeInterval)delay
{
    NSString* idStr = [NSString stringWithFormat:@"%p", ID];
    [[self _tipViewInfoWithID:idStr].progressHUD hide:animation afterDelay:delay];
}


#pragma mark- MBProgressHUDDelegate 
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    TipViewInfo* tipViewInfo = [self _tipViewInfoWithProgressHUD:hud];
    hud.delegate = nil;
    [hud removeFromSuperview];
    if (tipViewInfo)
    {
        [_tipViewList removeObject:tipViewInfo];
    }
}


@end
