//
//  ChatInputView.m
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "CommonTool.h"

#import "GEMTUserManager.h"

#import "ChatInputView.h"
#import "RecorderView.h"

@implementation ChatInputView
@synthesize delegate = _delegate;

#define kToolBar_ImageViewTag   1000

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) awakeFromNib
{
    self.isTextInput = NO;
    
    _recordTitle = @"按住评论";
    
    _recorderView = [RecorderView showRecorderViewOnView:self
                                          recordBtnFrame:_inputBgImageView.frame
                                                delegate:self];
    
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
    _recorderView.userInteractionEnabled = !isTextInput;
    
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
    [self endEditing:YES];
    self.isTextInput = !self.isTextInput;
}


#pragma mark- RecorderViewDelegate
- (void)RecorderView:(RecorderView *)recorderView recordId:(NSString *)recordId
{
    if ([_delegate respondsToSelector:@selector(ChatInputView:content:isText:)])
    {
        [_delegate ChatInputView:self content:recordId isText:NO];
    }
}


- (void)RecorderViewBeginRecord:(RecorderView *)recorderView
{
    [self _isRecordBtnOn:YES];
}


- (void)RecorderViewEndRecord:(RecorderView *)recorderView
{
    [self _isRecordBtnOn:NO];
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


- (void) setRecordTitle:(NSString *)recordTitle
{
    _recordTitle = recordTitle;
    
    self.recordTitleLabel.text = _recordTitle;
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
    
    if ([_delegate respondsToSelector:@selector(ChatInputView:changeOriginY:)])
    {
        [_delegate ChatInputView:self changeOriginY:self.frameY];
    }
    
    [UIView commitAnimations];
}


- (void) keyboradWillHidden:(NSNotification*)notification
{
    CGFloat duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    
    self.frameY = 0.0;
    
    if ([_delegate respondsToSelector:@selector(ChatInputView:changeOriginY:)])
    {
        [_delegate ChatInputView:self changeOriginY:self.frameY];
    }
    
    [UIView commitAnimations];
}


#pragma mark- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(ChatInputView:content:isText:)])
    {
        [_delegate ChatInputView:self content:textField.text isText:YES];
    }
    
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}


#pragma mark- hitTest
- (UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (_inputTextField.isEditing && point.y < [self _toolBarBgImageView].frameY)
    {
        [self endEditing:YES];
        return self;
    }
    
    if (point.y >= [self _toolBarBgImageView].frameY)
    {
        return [super hitTest:point withEvent:event];
    }
    
    return nil;
}

@end
