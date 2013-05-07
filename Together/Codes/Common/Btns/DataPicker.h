//
//  DataPicker.h
//  Together
//
//  Created by APPLE on 13-5-7.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMETTapView.h"

@class DataPicker;

@protocol DataPickerDelegate <NSObject>

- (void)DataPicker:(DataPicker*)d;

@end

@interface DataPicker : NSObject<GMETTapViewDelegate>
{
    UIDatePicker            *_iDatePicker;
}

- (void)showViewPickerInView:(UIView*)v;
@end
