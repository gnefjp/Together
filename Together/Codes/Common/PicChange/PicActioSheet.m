//
//  AvataActioSheet.m
//  Together
//
//  Created by APPLE on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "PicActioSheet.h"

@implementation PicActioSheet

@synthesize actionDelegate = _actionDelegate;

+(id)showWithDelegate:(id<PicActioSheetDelegate>)aDelegate
{
    PicActioSheet  *actionSheet = [[PicActioSheet alloc] initWithTitle:@"选择图片途径"
                                                                  delegate:nil
                                                         cancelButtonTitle:@"取消"
                                                    destructiveButtonTitle:nil
                                                         otherButtonTitles:@"系统图像" ,@"本地图像" ,@"拍照", nil];
    actionSheet.delegate = actionSheet;
    actionSheet.actionDelegate = aDelegate;
    [actionSheet showInView:[UIView rootView]];
    return actionSheet;
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            [_actionDelegate picActioSheet:self picType:ePicActioSheetType_SysPhoto];
            break;
        }
        case 1:
        {
            [_actionDelegate picActioSheet:self picType:ePicActioSheetType_LocalPhoto];
            break;
        }
        case 2:
        {
            [_actionDelegate picActioSheet:self picType:ePicActioSheetType_TakePhoto];
            break;
        }
        default:
            break;
    }
}

@end
