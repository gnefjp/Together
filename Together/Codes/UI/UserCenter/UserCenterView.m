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

- (void)ChangeAvatarSelectImage:(UIImage *)img
{
    AvatarCutView *cutView = [AvatarCutView loadFromNib];
    cutView.delegate = self;
    [cutView initWithImage:img];
    [[UIView rootView] addSubview:cutView];
    [cutView showAnimation];
}

- (void)avataImageDidReceive:(UIImage *)img
{
    _iAvatarImage.image = img;
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
    if (!_avatar) {
        _avatar = [[ChangeAvatar alloc] init];
        _avatar.delegate = self;
    }
    [_avatar addAvataActionSheet];
}

- (IBAction)_playBtnDidPressed:(id)sender
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryAmbient error:nil];
    [session setActive:YES error:nil];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:
                                   [GMETRecorder getRecordFileUrl] error:nil];
    [_player prepareToPlay];
    [_player play];
}

@end
