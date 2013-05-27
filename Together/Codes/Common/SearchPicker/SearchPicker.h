//
//  SearchPicker.h
//  Together
//
//  Created by Gnef_jp on 13-5-8.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMETTapView.h"

@class SearchPicker;
@protocol SearchPickerDelegate <NSObject>
- (void) SearchPicker:(SearchPicker *)searchPicker changeValue:(int)value;
@end

typedef enum
{
    SearchPickerType_RoomType   = 0,
    SearchPickerType_Distance   = 1,
    
    SearchPickerType_Belongs    = 2,
    SearchPickerType_State      = 3,
    
    SearchPickerType_Max        = 4,
} SearchPickerType;

@interface SearchPicker : UIView
{
    __weak id <SearchPickerDelegate>    _delegate;
    GMETTapView                         *_tapView;
}

@property (weak,   nonatomic) id                delegate;
@property (assign, nonatomic) NSArray           *data;
@property (assign, nonatomic) SearchPickerType  type;

+ (SearchPicker *) showPickerWithData:(NSArray *)array origin:(CGPoint)origin delegate:(id)delegate;

- (void) hidePicker:(BOOL)animation;

@end
