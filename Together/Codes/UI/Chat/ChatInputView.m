//
//  ChatInputView.m
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "CommonTool.h"
#import "TipViewManager.h"

#import "GEMTUserManager.h"

#import "ChatInputView.h"

@implementation ChatInputView
@synthesize delegate = _delegate;

#define kToolBar_ImageViewTag   1000

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[TipViewManager defaultManager] removeTipWithID:self];
}

- (void) awakeFromNib
{
    self.isTextInput = NO;
    
    _recordTitle = @"按住评论";
    _recordStateView.alpha = 0.0f;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboradWillHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


- (UIImageView *) _toolBarBgImageView
{
    return [self viewWithTag:kToolBar_ImageViewTag recursive:NO];
}


- (void) setIsTextInput:(BOOL)isTextInput
{
    _isTextInput = isTextInput;
    
    NSString *btnImages[] = {
        @"chat_toolbar_text_btn",
        @"chat_toolbar_record_btn",
    };
    
    NSString *bgImages[] = {
        @"chat_toolbar_audio_btn_a.png",
        @"chat_toolbar_text_bg.png",
    };
    
    [_changeTypeBtn setImageWithName:btnImages[_isTextInput]];
    _inputBgImageView.image = [UIImage imageNamed:bgImages[_isTextInput]];
    
    _recordTitleLabel.hidden = _isTextInput;
    _inputTextField.hidden = !_isTextInput;
    
    if (_isTextInput)
    {
        [_inputTextField becomeFirstResponder];
    }
}


- (IBAction)changeInputType:(id)sender
{
    self.isTextInput = !self.isTextInput;
}


#pragma mark- 录音
- (void) _isRecordBtnOn:(BOOL)isOn
{
    NSString *bgImages[] = {
        @"chat_toolbar_audio_btn_a.png",
        @"chat_toolbar_audio_btn_b.png",
    };
    
    _inputBgImageView.image = [UIImage imageNamed:bgImages[isOn]];
    
    NSString *recordTitles[] = {
        _recordTitle,
        @"松开结束",
    };
    
    _recordTitleLabel.text = recordTitles[isOn];
    
    UIColor *titleColors[] = {
        GMETColorRGBMake(39, 39, 39),
        [UIColor whiteColor],
    };
    
    _recordTitleLabel.textColor = titleColors[isOn];
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
    
    [self _isRecordBtnOn:isRecording];
}


- (void) setRecordTitle:(NSString *)recordTitle
{
    _recordTitle = recordTitle;
    
    self.recordTitleLabel.text = _recordTitle;
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


#pragma mark- 键盘事件
- (void) keyboardWillShow:(NSNotification*)notification
{
    CGFloat duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGSize keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat keyHeight = MIN(keyboardSize.width, keyboardSize.height);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    
    self.frameY = -keyHeight;
    
    [UIView commitAnimations];
}


- (void) keyboradWillHidden:(NSNotification*)notification
{
    CGFloat duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    
    self.frameY = 0.0;
    
    [UIView commitAnimations];
}


#pragma mark- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // TODO: 发送
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}


#pragma mark- NetFileRequestDelegate
- (void) NetFileRequestFail:(NetFileRequest *)request
{
    [[TipViewManager defaultManager] showTipText:@"上传失败"
                                       imageName:kCommonImage_FailIcon
                                          inView:self
                                              ID:self];
    
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES delay:1.25];
}


- (void) NetFileRequestSuccess:(NetFileRequest *)request
{
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
    
    FileUploadRequest *uploadRequest = (FileUploadRequest *)request;
    
    if ([uploadRequest.fileID length] > 0)
    {
        if ([_delegate respondsToSelector:@selector(ChatInputView:content:isText:)])
        {
            [_delegate ChatInputView:self content:uploadRequest.fileID isText:NO];
        }
    }
}


#pragma mark- TouchedDelegate
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    if (!_isTextInput && CGRectContainsPoint(_inputBgImageView.frame, touchPoint))
    {
        [self _setIsRecording:YES];
        
        [self _isShowRemove:NO];
        [self _isWantToRemove:NO];
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isRecording)
    {
        CGPoint touchPoint = [[touches anyObject] locationInView:self];
        
        [self _isShowRemove:!CGRectContainsPoint(_inputBgImageView.frame, touchPoint)];
        [self _isWantToRemove:CGRectContainsPoint(_recordStateView.frame, touchPoint)];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
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
            uploadRequest.filePath = _recordTmpFilePath;
            uploadRequest.userID = [GEMTUserManager defaultManager].userInfo.userId;
            uploadRequest.sid = [GEMTUserManager defaultManager].sId;
            
            [[NetRequestManager defaultManager] startRequest:uploadRequest];
        }
        
        [self _setIsRecording:NO];
    }
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isRecording)
    {
        [self _setIsRecording:NO];
    }
}


#pragma mark- hitTest
- (UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([[TipViewManager defaultManager] progressHUDWithID:self] != nil)
    {
        // 正在加载
        return self;
    }
    
    if (_isRecording)
    {
        return self;
    }
    
    if (_inputTextField.isEditing && point.y < [self _toolBarBgImageView].frameY)
    {
        [self endEditing:YES];
        return self;
    }
    
    if (CGRectContainsPoint([self _toolBarBgImageView].frame, point))
    {
        return [super hitTest:point withEvent:event];
    }
    
    return nil;
}

@end
