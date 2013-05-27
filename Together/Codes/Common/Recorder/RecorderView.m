//
//  RecorderView.m
//  Together
//
//  Created by APPLE on 13-5-17.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RecorderView.h"
#import "TipViewManager.h"
#import "GEMTUserManager.h"

@implementation RecorderView

#define kDefaultMaxRecordTime   30 // 秒


+ (RecorderView *) showRecorderViewOnView:(UIView *)view
                           recordBtnFrame:(CGRect)btnFrame
                                 delegate:(id<RecorderViewDelegate>)delegate
{
    RecorderView *recorderView = [RecorderView loadFromNib];
    recorderView.delegate = delegate;
    recorderView.recordFrame = btnFrame;
    
    [view addSubview:recorderView];
    
    return recorderView;
}


- (void)awakeFromNib
{
    _recordStateView.alpha = 0.0f;
    
    _recordMaxTime = kDefaultMaxRecordTime;
}


- (void) _setIsRecording:(BOOL)isRecording
{
    _isRecording = isRecording;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                         _recordStateView.alpha = isRecording ? 1.0 : 0.0;
                     }completion:^(BOOL finished){
                         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                     }];
}


- (void) _isShowRemove:(BOOL)isShowRemove
{
    _recordRemoveImageView.hidden = !isShowRemove;
    _recordEmptyImageView.hidden = isShowRemove;
    _recordDBImageView.hidden = isShowRemove;
}


- (void) _isWantToRemove:(BOOL)isWantToRemove
{
    NSString *removeImages[] = {
        @"chat_recorder_cancel_a.png",
        @"chat_recorder_cancel_b.png"
    };
    
    _recordRemoveImageView.image = [UIImage imageNamed:removeImages[isWantToRemove]];
}


#pragma mark- hitTest
- (UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (!self.userInteractionEnabled)
    {
        return nil;
    }
    
    if ([[TipViewManager defaultManager] progressHUDWithID:self] != nil)
    {
        return self;
    }
        
    if (_isRecording)
    {
        return self;
    }
    
    if (CGRectContainsPoint(_recordFrame, point))
    {
        return self;
    }
    
    return nil;
}


#pragma mark- TouchesDelegate
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(_recordFrame, touchPoint))
    {
        _recorder = [GMETRecorder startRecordWithTime:_recordMaxTime];
        [_recorder start];
        _isRecording = YES;
        [self _setIsRecording:YES];
        [self _isShowRemove:NO];
        [self _isWantToRemove:NO];
        [_delegate RecorderViewBeginRecord:self];
    }
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isRecording)
    {
        CGPoint touchPoint = [[touches anyObject] locationInView:self];
        
        [self _isShowRemove:!CGRectContainsPoint(_recordFrame, touchPoint)];
        [self _isWantToRemove:CGRectContainsPoint(_recordStateView.frame, touchPoint)];
    }
}



- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_recorder stop];
    if (_isRecording)
    {
        CGPoint touchPoint = [[touches anyObject] locationInView:self];
        if (!CGRectContainsPoint(_recordStateView.frame, touchPoint))
        {
            [[TipViewManager defaultManager] showTipText:nil
                                               imageName:nil
                                                  inView:self
                                                      ID:self];
            _upload = [[AsyncSocketUpload alloc] init];
            _upload.userID = [GEMTUserManager defaultManager].userInfo.userId;
            _upload.delegate = self;
            _upload.sid = [GEMTUserManager defaultManager].sId;
            _upload.filePath = [GMETRecorder getRecordFilePath];
            [_upload starRequest];
        
        //测试录制的音频
//            AVAudioSession *session = [AVAudioSession sharedInstance];
//            [session setCategory:AVAudioSessionCategoryAudioProcessing error:nil];
//            [session setActive:YES error:nil];
//
//            NSLog(@"%@",[GMETRecorder getRecordFileUrl]);
//            _player = [[AVAudioPlayer alloc] initWithContentsOfURL:
//                       [GMETRecorder getRecordFileUrl] error:nil];
//            [_player prepareToPlay];
//            [_player play];
        }
        
        [_delegate RecorderViewEndRecord:self];
        [self _setIsRecording:NO];
    }
}


- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_recorder stop];
    if (_isRecording)
    {
        [self _setIsRecording:NO];
        [_delegate RecorderViewEndRecord:self];
    }
}

#pragma mark- ReocrderDelegate
- (void)AsyncSocketUploadSuccess:(AsyncSocketUpload *)uploadObject
{
    [_delegate RecorderView:self recordId:uploadObject.fileID];
    [[TipViewManager defaultManager] showTipText:@"上传成功"
                                       imageName:kCommonImage_SuccessIcon
                                          inView:self
                                              ID:self];
    
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES delay:1.25];
    
}

- (void)AsyncSocketUploadFail:(AsyncSocketUpload *)uploadObject
{
    [[TipViewManager defaultManager] showTipText:@"上传失败"
                                       imageName:kCommonImage_FailIcon
                                          inView:self
                                              ID:self];
    
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES delay:1.25];

}
@end
