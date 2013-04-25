//
//  AvataActioSheet.h
//  Together
//
//  Created by APPLE on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PicActioSheet;


typedef enum
{
    ePicActioSheetType_SysPhoto,
    ePicActioSheetType_LocalPhoto,
    ePicActioSheetType_TakePhoto
}ePicActioSheetType;

@protocol PicActioSheetDelegate <NSObject>

- (void)picActioSheet:(PicActioSheet*)p picType:(ePicActioSheetType)eType;

@end


@interface PicActioSheet : UIActionSheet<UIActionSheetDelegate>
{
    __weak id<PicActioSheetDelegate>     _actionDelegate;
}

@property (weak,nonatomic) id<PicActioSheetDelegate>     actionDelegate;

+(id)showWithDelegate:(id<PicActioSheetDelegate>)aDelegate;

@end
