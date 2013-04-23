//
//  AvataActioSheet.m
//  Together
//
//  Created by APPLE on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "AvataActioSheet.h"

@implementation AvataActioSheet
@synthesize actionDelegate = _actionDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(void)showWithDelegate:(id<AvataActioSheetDelegate>)aDelegate
{
    AvataActioSheet  *actionSheet = [[AvataActioSheet alloc] initWithTitle:@"选择图片途径"
                                                                delegate:nil
                                                       cancelButtonTitle:@"取消"
                                                  destructiveButtonTitle:nil
                                                       otherButtonTitles:@"系统图像",@"拍照",@"本地图像", nil];
    actionSheet.delegate = actionSheet;
    actionSheet.actionDelegate = aDelegate;
    [actionSheet showInView:[UIView rootView]];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [_actionDelegate SysPhotoBtnDidPressed];
            break;
        case 1:
        {
            [_actionDelegate LocalPhotoBtnDidPressed];
        }
            break;
        case 2:
        {
             [_actionDelegate TakePhotoBtnDidPressed];
        }
            break;
        default:
            break;
    }
}

- (void)dealloc
{
    
}

@end
