//
//  PicCutView.h
//  Together
//
//  Created by APPLE on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtGestureHelper.h"

@class PicCutView;

@protocol PicCutViewDelegate <NSObject>

- (void)PicCutView:(PicCutView*)pic
             image:(UIImage*)img;

@end

@interface PicCutView : UIView
{
    UIView                              *_holeView;
    UIImageView                         *_imageView;
    
    __weak IBOutlet UIImageView         *_cutView;
    PtGestureHelper                     *_gestureHelper;
    __weak id<PicCutViewDelegate>       _delegate;
}

- (void) initWithImage:(UIImage*)image;

@property (weak) id<PicCutViewDelegate>       delegate;
@end
