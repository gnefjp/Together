//
//  TipViewManager.h
//  MaxDoodle
//
//  Created by Gnef_jp on 13-4-1.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "MBProgressHUD.h"

@interface TipViewManager : NSObject <MBProgressHUDDelegate>
{
    NSMutableArray*     _tipViewList;
}

+ (TipViewManager*) defaultManager;

- (void) removeTipWithID:(id)ID;
- (MBProgressHUD *) progressHUDWithID:(id)ID;

- (MBProgressHUD *) showTipText:(NSString*)tipText
                      imageName:(NSString*)imageName
                         inView:(UIView*)inView
                             ID:(id)ID;

- (void) hideTipWithID:(id)ID animation:(BOOL)animation;
- (void) hideTipWithID:(id)ID animation:(BOOL)animation delay:(NSTimeInterval)delay;

@end
