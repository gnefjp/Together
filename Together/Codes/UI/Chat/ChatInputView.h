//
//  ChatInputView.h
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChatInputView : UIView
{
    __weak IBOutlet UIView *_recordStateView;
    __weak IBOutlet UIImageView *_recordEmptyImageView;
    __weak IBOutlet UIImageView *_recordDBImageView;
    __weak IBOutlet UIImageView *_recordRemoveImageView;
    BOOL        _isRecording;
}

@property (copy,  nonatomic) NSString               *recordTitle;

@property (assign, nonatomic) BOOL                  isTextInput;
@property (weak, nonatomic) IBOutlet UILabel        *recordTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField    *inputTextField;
@property (weak, nonatomic) IBOutlet UIImageView    *inputBgImageView;
@property (weak, nonatomic) IBOutlet UIButton       *changeTypeBtn;

- (IBAction)changeInputType:(id)sender;

@end
