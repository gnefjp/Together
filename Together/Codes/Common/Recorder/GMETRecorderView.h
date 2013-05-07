//
//  GMETRecorderView.h
//  Together
//
//  Created by APPLE on 13-5-7.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMETRecorder.h"

@class GMETRecorderView;

@protocol GMETRecorderViewDelegate <NSObject>

- (void)GMETRecorderViewDidCancel:(GMETRecorderView*)aView;

- (void)GmetRecorderViewDidSuccess:(GMETRecorderView*)aView;

@end

@interface GMETRecorderView : UIView
{
    __weak IBOutlet UIButton            *_longPressBtn;
    GMETRecorder                        *_recorder;
    AVAudioPlayer                       *_player;
}

- (IBAction)cancelBtnDidPressed:(id)sender;
- (IBAction)rerecord:(id)sender;
- (IBAction)playRecord:(id)sender;
- (IBAction)submitRecord:(id)sender;
- (IBAction)stopRecord:(id)sender;


@end
