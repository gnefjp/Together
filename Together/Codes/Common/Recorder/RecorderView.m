//
//  RecorderView.m
//  Together
//
//  Created by APPLE on 13-5-17.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RecorderView.h"
#import "TipViewManager.h"
#import "FileUploadRequest.h"
#import "GEMTUserManager.h"

@implementation RecorderView
@synthesize recordFrame;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    _recordStateView.alpha = 0.0f;
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
    if ([[TipViewManager defaultManager] progressHUDWithID:self] != nil)
    {
        return self;
    }
        
    if (_isRecording)
    {
        return self;
    }
    
    if (CGRectContainsPoint(recordFrame, point))
    {
        return self;
    }
    
    return nil;
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(recordFrame, touchPoint))
    {
        _recorder = [GMETRecorder startRecordWithTime:30];
        [_recorder start];
        _isRecording = YES;
        [self _setIsRecording:YES];
        [self _isShowRemove:NO];
        [self _isWantToRemove:NO];
        [_delegate RecorderViewBeginTouch:self];
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isRecording)
    {
        CGPoint touchPoint = [[touches anyObject] locationInView:self];
        
        [self _isShowRemove:!CGRectContainsPoint(recordFrame, touchPoint)];
        [self _isWantToRemove:CGRectContainsPoint(recordFrame, touchPoint)];
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
            
            FileUploadRequest *uploadRequest = [[FileUploadRequest alloc] init];
            uploadRequest.delegate = self;
            uploadRequest.filePath = [GMETRecorder getRecordFilePath];
            uploadRequest.userID = [GEMTUserManager defaultManager].userInfo.userId;
            uploadRequest.sid = [GEMTUserManager defaultManager].sId;
            
            [[NetRequestManager defaultManager] startRequest:uploadRequest];
            
        
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
        [_delegate RecorderViewEndTouch:self];
        [self _setIsRecording:NO];
    }
}

- (void)NetFileRequestSuccess:(NetFileRequest *)request
{
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
    
    FileUploadRequest *uploadRequest = (FileUploadRequest *)request;
    
    if ([uploadRequest.fileID length] > 0)
    {
        [_delegate RecorderView:self successrecorderId:uploadRequest.fileID];
    }

}

- (void)NetFileRequestFail:(NetFileRequest *)request
{
    [[TipViewManager defaultManager] showTipText:@"上传失败"
                                       imageName:kCommonImage_FailIcon
                                          inView:self
                                              ID:self];
    
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES delay:1.25];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_recorder stop];
    if (_isRecording)
    {
        [self _setIsRecording:NO];
        [_delegate RecorderViewEndTouch:self];
    }
}
@end
