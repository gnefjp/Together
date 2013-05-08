//
//  DataPicker.m
//  Together
//
//  Created by APPLE on 13-5-7.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "DataPicker.h"

@implementation DataPicker
@synthesize delegate = _delegate;

- (void)showViewPickerInView:(UIView*)v
{
    GMETTapView* tapView = [[GMETTapView alloc] initWithFrame:[UIView rootView].bounds];
    tapView.delegate = self;
    tapView.backgroundColor = [UIColor blackColor];
    tapView.alpha = 0.0f;
    [v addSubview:tapView];
    
    _iDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0,354 + 586 ,0.0,0.0)];
    _iDatePicker.datePickerMode = UIDatePickerModeDate;
    [_iDatePicker setDate:[NSDate date]];
    [_iDatePicker addTarget:self action:@selector(dateChanged:)
           forControlEvents:UIControlEventValueChanged];
    [v addSubview:_iDatePicker];
    
    
    [UIView animateWithDuration:0.4 animations:^(void)
     {
         tapView.alpha = 0.6f;
         _iDatePicker.frameY = 354;
     }];
}

- (void)GMETTapView:(GMETTapView *)tapView touchBegin:(UIEvent *)event
{
    
}

- (void)GMETTapView:(GMETTapView *)tapView touchEnded:(UIEvent *)event
{
    [UIView animateWithDuration:0.4 animations:^(void)
     {
         tapView.alpha = 0.0f;
         _iDatePicker.frameY = 354 + 586;
     }completion:^(BOOL isFinished)
     {
         [tapView removeFromSuperview];
         [_iDatePicker removeFromSuperview];
         _iDatePicker = nil;
     }];
}


-(void)dateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    [_delegate DataPicker:self date:_date];
}

@end
