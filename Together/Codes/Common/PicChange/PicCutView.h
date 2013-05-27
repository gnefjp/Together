//
//  PicCutView.h
//  Together
//
//  Created by APPLE on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtGestureHelper.h"

typedef enum {
    cutType_room,
    cutType_avatar
}cutType;

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
    cutType                             _eType;
}

- (void) initWithImage:(UIImage*)image;
- (IBAction)closeBtnDidPressed:(id)sender;


@property (weak)      id<PicCutViewDelegate>       delegate;
@property (nonatomic) cutType                      eType;
@end
