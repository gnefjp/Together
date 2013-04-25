//
//  UserCenterView.m
//  Together
//
//  Created by APPLE on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserCenterView.h"
#import "GMETRecorder.h"

@implementation UserCenterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)showMapViewBtnDidpressed:(id)sender
{
    MapView *mapView = [MapView loadFromNib];
    [[UIView rootView] addSubview:mapView];
    [mapView showAnimation];
    mapView.delegate = self;
}

- (void)MapView:(MapView *)view location:(CLLocationCoordinate2D)aLocation
{
    NSLog(@"%lf,%lf",aLocation.latitude,aLocation.longitude);
}

- (void)PicChangeSuccess:(PicChange *)self img:(UIImage *)img
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
        _avatar = [[PicChange alloc] init];
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
