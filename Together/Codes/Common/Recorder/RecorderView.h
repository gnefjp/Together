//
//  RecorderView.h
//  Together
//
//  Created by APPLE on 13-5-17.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecorderView : UIView
{
    BOOL        _isRecording;
    __weak IBOutlet UIView *_recordStateView;
    __weak IBOutlet UIImageView *_recordEmptyImageView;
    __weak IBOutlet UIImageView *_recordDBImageView;
    __weak IBOutlet UIImageView *_recordRemoveImageView;
}

@property (nonatomic) CGRect recordFrame;

@end
