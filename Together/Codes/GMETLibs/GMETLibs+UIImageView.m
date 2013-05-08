//
//  GMETLibs+UIImageView.m
//  Together
//
//  Created by Gnef_jp on 13-5-8.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GMETLibs+UIImageView.h"

@implementation UIImageView(GMETLibs)

- (void) setImage:(UIImage *)image animation:(BOOL)animation
{
    UIImageView* tmpImageView = [[UIImageView alloc] initWithFrame:self.frame];
    tmpImageView.image = self.image;
    [self.superview insertSubview:tmpImageView belowSubview:self];
    
    self.alpha = 0.0f;
    self.image = image;
    [UIView animateWithDuration:0.5 animations:^(void){
        self.alpha = 1.0f;
        tmpImageView.alpha = 0.0f;
    } completion:^(BOOL finished){
        [tmpImageView removeFromSuperview];
    }];
}

@end
