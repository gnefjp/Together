//
//  ChatInputView.h
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FileUploadRequest.h"

@class ChatInputView;
@protocol ChatInputViewDelegate <NSObject>
- (void) ChatInputView:(ChatInputView *)chatInputView
               content:(NSString *)content
                isText:(BOOL)isText;
@end

@interface ChatInputView : UIView <NetFileRequestDelegate>
{
    BOOL                                    _isRecording;
    
    NSString                                *_recordTmpFilePath;
    __weak IBOutlet UIView                  *_recordStateView;
    __weak IBOutlet UIImageView             *_recordEmptyImageView;
    __weak IBOutlet UIImageView             *_recordDBImageView;
    
    __weak IBOutlet UIImageView             *_recordRemoveImageView;
    
    __weak id <ChatInputViewDelegate>       _delegate;
}

@property (weak,   nonatomic) id                        delegate;
@property (copy,   nonatomic) NSString                  *recordTitle;

@property (assign, nonatomic) BOOL                      isTextInput;
@property (weak,   nonatomic) IBOutlet UILabel          *recordTitleLabel;
@property (weak,   nonatomic) IBOutlet UITextField      *inputTextField;
@property (weak,   nonatomic) IBOutlet UIImageView      *inputBgImageView;
@property (weak,   nonatomic) IBOutlet UIButton         *changeTypeBtn;

- (IBAction)changeInputType:(id)sender;

@end
