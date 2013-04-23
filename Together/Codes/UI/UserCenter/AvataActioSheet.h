//
//  AvataActioSheet.h
//  Together
//
//  Created by APPLE on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AvataActioSheetDelegate <NSObject>

- (void)SysPhotoBtnDidPressed;
- (void)LocalPhotoBtnDidPressed;
- (void)TakePhotoBtnDidPressed;

@end

@interface AvataActioSheet : UIActionSheet<UIActionSheetDelegate>
{
    __weak id<AvataActioSheetDelegate>     _actionDelegate;
}

@property (nonatomic,weak) id<AvataActioSheetDelegate>     actionDelegate;

+(void)showWithDelegate:(id<AvataActioSheetDelegate>)aDelegate;
@end
