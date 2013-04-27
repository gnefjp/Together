//
//  RoomTypePickerView.h
//  Together
//
//  Created by Gnef_jp on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

@class RoomTypePickerView;
@protocol RoomTypePickerViewDelegate <NSObject>
- (void) RoomTypePickerViewWantCancel:(RoomTypePickerView *)roomTypePickerView;
- (void) RoomTypePickerView:(RoomTypePickerView *)pickerView pickRoomType:(RoomType)roomType;
@end

@interface RoomTypePickerView : UIView
{
    __weak id <RoomTypePickerViewDelegate>     _delegate;
}

@property (weak, nonatomic) id      delegate;

- (IBAction)cancelBtnPressed:(id)sender;

@end
