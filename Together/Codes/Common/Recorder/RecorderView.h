//
//  RecorderView.h
//  Together
//
//  Created by APPLE on 13-5-17.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMETRecorder.h"
#import "AsyncSocketUpload.h"
@class RecorderView;

@protocol RecorderViewDelegate <NSObject>
- (void)RecorderView:(RecorderView*)recorderView recordId:(NSString*)recordId;
- (void)RecorderViewBeginRecord:(RecorderView*)recorderView;
- (void)RecorderViewEndRecord:(RecorderView*)recorderView;
@end


@interface RecorderView : UIView<AsyncSocketUploadDelegate>
{
    __weak IBOutlet UIView                  *_recordStateView;
    __weak IBOutlet UIImageView             *_recordEmptyImageView;
    __weak IBOutlet UIImageView             *_recordDBImageView;
    __weak IBOutlet UIImageView             *_recordRemoveImageView;
    AsyncSocketUpload                       *_upload;
    GMETRecorder                            *_recorder;
    AVAudioPlayer                           *_player;
}

@property (weak,   nonatomic) id<RecorderViewDelegate>      delegate;

@property (assign, nonatomic) BOOL                          isRecording;
@property (assign, nonatomic) CGRect                        recordFrame;
@property (assign, nonatomic) NSInteger                     recordMaxTime;


+ (RecorderView *) showRecorderViewOnView:(UIView *)view
                           recordBtnFrame:(CGRect)btnFrame
                                 delegate:(id<RecorderViewDelegate>)delegate;
@end
