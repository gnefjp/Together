//
//  SearchPicker.m
//  Together
//
//  Created by Gnef_jp on 13-5-8.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "SearchPicker.h"

#define kBtnTag    1000

@implementation SearchPicker
@synthesize delegate = _delegate;


+ (SearchPicker *) showPickerWithData:(NSArray *)array origin:(CGPoint)origin delegate:(id)delegate
{
    SearchPicker *picker = [[SearchPicker alloc] init];
    picker.delegate = delegate;
    picker.data = array;
    
    picker.frameOrigin = origin;
    picker.alpha = 0.0f;
    [[UIView rootView] addSubview:picker];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                         picker.alpha = 1.0f;
                     }completion:^(BOOL finished){
                         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                     }];
    
    return picker;
}


- (void) hidePicker:(BOOL)animation
{
    if (animation)
    {
        [UIView animateWithDuration:0.3
                         animations:^{
                             
                             [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                             self.alpha = 0.0f;
                             
                         }completion:^(BOOL finished){
                             
                             [_tapView removeFromSuperview];
                             _tapView = nil;
                             [self removeFromSuperview];
                             [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                             
                         }];
    }
    else
    {
        [_tapView removeFromSuperview];
        _tapView = nil;
        [self removeFromSuperview];
    }
}


- (void) dealloc
{
    [_tapView removeFromSuperview];
}


- (id) init
{
    self = [super init];
    if (self)
    {
        _tapView = [[GMETTapView alloc] initWithFrame:[UIView rootView].bounds];
        _tapView.backgroundColor = [UIColor clearColor];
        _tapView.alpha = 1.0;
        _tapView.delegate = self;
        
        [[UIView rootView] addSubview:_tapView];
    }
    return self;
}


- (void) _btnTouchDown:(UIButton *)btn
{
    [self hidePicker:YES];
    
    if ([_delegate respondsToSelector:@selector(SearchPicker:changeValue:)])
    {
        [_delegate SearchPicker:self changeValue:btn.tag - kBtnTag];
    }
}


- (UIButton *) _btnWithText:(NSString *)text origin:(CGPoint)origin
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"room_ screen_btn_a.png"]
                   forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"room_ screen_btn_b.png"]
                   forState:UIControlStateHighlighted];
    
    btn.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:14];
    btn.frameOrigin = origin;
    
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:GMETColorRGBMake(39, 39, 39) forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateHighlighted];
    [btn setTitleColor:GMETColorRGBMake(39, 39, 39) forState:UIControlStateHighlighted];
    
    [btn addTarget:self
            action:@selector(_btnTouchDown:)
  forControlEvents:UIControlEventTouchDown];
    
    return btn;
}


- (void) setData:(NSArray *)data
{
    CGPoint origin = CGPointZero;
    for (int i = 0, len = data.count; i < len; ++i)
    {
        UIButton *btn = [self _btnWithText:[data objectAtIndex:i]
                                    origin:origin];
        btn.tag = kBtnTag + i;
        [self addSubview:btn];
        
        origin.y += btn.boundsHeight;
    }
    
    self.boundsSize = CGSizeMake(160, origin.y);
}


#pragma mark- GMETTapViewDelegate
- (void) GMETTapView:(GMETTapView *)tapView touchEnded:(UIEvent *)event
{
    [self hidePicker:YES];
}


@end
