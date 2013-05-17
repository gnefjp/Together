//
//  RecorderView.h
//  Together
//
//  Created by APPLE on 13-5-17.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMETRecorder.h"
#import "FileUploadRequest.h"

@class RecorderView;

@protocol RecorderViewDelegate <NSObject>

- (void)RecorderView:(RecorderView*)v successrecorderId:(NSString*)recordId;
- (void)RecorderViewBeginTouch:(RecorderView*)v;
- (void)RecorderViewEndTouch:(RecorderView*)v;
@end

@interface RecorderView : UIView<NetFileRequestDelegate>
{
    BOOL                                    _isRecording;
    __weak IBOutlet UIView                  *_recordStateView;
    __weak IBOutlet UIImageView             *_recordEmptyImageView;
    __weak IBOutlet UIImageView             *_recordDBImageView;
    __weak IBOutlet UIImageView             *_recordRemoveImageView;
    GMETRecorder                            *_recorder;
    AVAudioPlayer                           *_player;
    id<RecorderViewDelegate>                _delegate;
}

@property (nonatomic) CGRect                       recordFrame;
@property (nonatomic) id<RecorderViewDelegate>     delegate;
@end
