//
//  ChatInputView.h
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RecorderView.h"

@class ChatInputView;
@protocol ChatInputViewDelegate <NSObject>
- (void) ChatInputView:(ChatInputView *)chatInputView
               content:(NSString *)content
                isText:(BOOL)isText;

- (void) ChatInputView:(ChatInputView *)chatInputView changeOriginY:(CGFloat)originY;
@end


@interface ChatInputView : UIView <RecorderViewDelegate>
{
    RecorderView                            *_recorderView;
    
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
