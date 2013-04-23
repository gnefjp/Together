//
//  UserCenterView.m
//  Together
//
//  Created by APPLE on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserCenterView.h"

@implementation UserCenterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




- (IBAction)recordBtnDidPressed:(id)sender
{
    if (!_recorder) {
        _recorder = [GMETRecorder startRecordWithTime:30];
    }
    [_recorder start];
}

- (IBAction)stopRecordBtnDidPressed:(id)sender
{
    [_recorder stop];
}

- (IBAction)changeAvataBtnDidPressed:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图片途径"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                    otherButtonTitles:@"系统图像",@"拍照",@"本地图像", nil];
    [actionSheet showInView:self];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            NSLog(@"0");
            break;
        case 1:
             NSLog(@"1");
            break;
        case 2:
             NSLog(@"2");
        default:
            break;
    }
}

- (IBAction)_playBtnDidPressed:(id)sender
{
    NSLog(@"%@",[GMETRecorder getRecordFileUrl]);
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryAmbient error:nil];
    [session setActive:YES error:nil];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:
                                   [GMETRecorder getRecordFileUrl] error:nil];
    [_player prepareToPlay];
    [_player play];
}

@end
