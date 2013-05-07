//
//  GMETRecorderView.m
//  Together
//
//  Created by APPLE on 13-5-7.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GMETRecorderView.h"

@implementation GMETRecorderView

- (void)awakeFromNib
{
    UILongPressGestureRecognizer *longPressGR =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handleLongPress2:)];
    longPressGR.allowableMovement=NO;
    longPressGR.minimumPressDuration = 0.2;
    [_longPressBtn addGestureRecognizer:longPressGR];
}

- (void)handleLongPress2:(id)sender
{
    if (!_recorder)
    {
        _recorder = [GMETRecorder startRecordWithTime:30];
    }
    [_recorder start];
}



- (IBAction)cancelBtnDidPressed:(id)sender
{
    
}

- (IBAction)rerecord:(id)sender
{
    
}

- (IBAction)playRecord:(id)sender
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryAmbient error:nil];
    [session setActive:YES error:nil];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:
               [GMETRecorder getRecordFileUrl] error:nil];
    [_player prepareToPlay];
    [_player play];
}

- (IBAction)submitRecord:(id)sender
{
    NSLog(@"submit");
}

- (IBAction)stopRecord:(id)sender
{
    [_recorder stop];
}
@end
