//
//  GMETLibs+UIImageView.m
//  Together
//
//  Created by Gnef_jp on 13-5-8.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GMETLibs+UIImageView.h"

static CGContextRef _newBitmapContext(CGSize size)
{
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    size_t imgWith = (size_t)(size.width + 0.5);
	size_t imgHeight = (size_t)(size.height + 0.5);
	size_t bytesPerRow = imgWith * 4;
    
	CGContextRef context = CGBitmapContextCreate(
												 NULL,
												 imgWith,
												 imgHeight,
												 8,
												 bytesPerRow,
												 colorSpaceRef,
												 (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    CGColorSpaceRelease(colorSpaceRef);
    return context;
}


#pragma mark- UIImageView
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


#pragma mark- UIImage
@implementation UIImage(GMETLibs)

- (UIImage*) transToBitmapImage
{
    return [self transToBitmapImageWithSize:self.size];
}

- (UIImage*) transToBitmapImageWithSize:(CGSize)size
{
	CGContextRef context = _newBitmapContext(size);
	
	CGRect drawRect = CGRectMake(0, 0, size.width, size.height);
	CGContextDrawImage(context, drawRect, self.CGImage);
	
	CGImageRef imgRef = CGBitmapContextCreateImage(context);
	UIImage* image = [UIImage imageWithCGImage:imgRef];
	
	CGContextRelease(context);
	CGImageRelease(imgRef);
	
	return image;
}

@end