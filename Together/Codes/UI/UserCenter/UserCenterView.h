//
//  UserCenterView.h
//  Together
//
//  Created by APPLE on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PicChange.h"
#import "MapView.h"

@class GMETRecorder;

@interface UserCenterView : UIView<PicChangeDelegate,MapViewDelegate>
{
    __weak IBOutlet UIImageView     *_iAvatarImage;
    GMETRecorder                    *_recorder;
    AVAudioPlayer                   *_player;
    PicChange                       *_avatar;
}

- (IBAction)showMapViewBtnDidpressed:(id)sender;
- (IBAction)recordBtnDidPressed:(id)sender;
- (IBAction)stopRecordBtnDidPressed:(id)sender;
- (IBAction)changeAvataBtnDidPressed:(id)sender;

@end
