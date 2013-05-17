//
//  ChatInputView.m
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "CommonTool.h"

#import "ChatInputView.h"

@implementation ChatInputView

#define kToolBar_ImageViewTag   1000

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) awakeFromNib
{
    self.isTextInput = NO;
    
    _recordTitle = @"按住评论";
    
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


- (void) setRecordTitle:(NSString *)recordTitle
{
    _recordTitle = recordTitle;
    
    self.recordTitleLabel.text = _recordTitle;
}


- (IBAction)changeInputType:(id)sender
{
    self.isTextInput = !self.isTextInput;
}


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


#pragma mark- TouchedDelegate
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    if (!_isTextInput && CGRectContainsPoint(_inputBgImageView.frame, touchPoint))
    {
        _isRecording = YES;
        [self _isRecordBtnOn:YES];
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _isRecording = NO;
    [self _isRecordBtnOn:NO];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _isRecording = NO;
    [self _isRecordBtnOn:NO];
}


#pragma mark- hitTest
- (UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"event : %@", event);
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
    
    NSLog(@"return nil");
    return nil;
}

@end
