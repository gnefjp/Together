//
//  RecorderView.m
//  Together
//
//  Created by APPLE on 13-5-17.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RecorderView.h"

@implementation RecorderView
@synthesize recordFrame;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) _isRecordBtnOn:(BOOL)isOn
{
    NSString *bgImages[] = {
        @"chat_toolbar_audio_btn_a.png",
        @"chat_toolbar_audio_btn_b.png",
    };
    
    UIColor *titleColors[] = {
        GMETColorRGBMake(39, 39, 39),
        [UIColor whiteColor],
    };
    
    
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(recordFrame, touchPoint))
    {
        _isRecording = YES;
        [self _isRecordBtnOn:YES];
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    _isRecording = NO;
//    [self _isRecordBtnOn:NO];
    
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
//    _isRecording = NO;
//    [self _isRecordBtnOn:NO];
    
}
@end
