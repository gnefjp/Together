//
//  UserCenterView.h
//  Together
//
//  Created by APPLE on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMETRecorder.h"

@interface UserCenterView : UIView<UIActionSheetDelegate>
{
    GMETRecorder        *_recorder;
    AVAudioPlayer       *_player;
}

- (IBAction)recordBtnDidPressed:(id)sender;
- (IBAction)stopRecordBtnDidPressed:(id)sender;
- (IBAction)changeAvataBtnDidPressed:(id)sender;

@end
