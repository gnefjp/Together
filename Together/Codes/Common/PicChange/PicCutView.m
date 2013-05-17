//
//  PicCutView.m
//  Together
//
//  Created by APPLE on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "PicCutView.h"

@implementation PicCutView
@synthesize delegate = _delegate;

static inline CGFloat ImageInitScale(CGSize imageSize, CGSize sceenSize)
{
    CGFloat widthScale = sceenSize.width / imageSize.width;
    CGFloat heightScale = sceenSize.height / imageSize.height;
    return MAX(widthScale, heightScale);
}

- (void)awakeFromNib
{
    
}

- (void) initWithImage:(UIImage*)image
{
    _holeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _holeView.backgroundColor = [UIColor whiteColor];
    _holeView.center = CGPointMake(160, 280);
    [self addSubview:_holeView];
    
    _imageView = [[UIImageView alloc] initWithImage:image];
    _imageView.center = _holeView.center;
    [self addSubview:_imageView];
    
    _gestureHelper = [[PtGestureHelper alloc] initWithAttached:self needChanged:_imageView];
    _gestureHelper.numberOfTouchesRequired = 1;
    [_gestureHelper attachPanGesture];
    [_gestureHelper attachRotationGesture];
    [_gestureHelper attachPinchGesture];
    [_gestureHelper attachDoubleTapGesture];
    _gestureHelper.initScale = ImageInitScale(_imageView.image.size, _holeView.frame.size);
    _imageView.transform = [_gestureHelper makeTransform];
    
    [self bringSubviewToFront:_cutView];
}

- (UIImage*) resultImageWithSize:(CGSize)size
{
    //UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, 1, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 将背景填充为白色
    CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 1.0f);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    // 平移，将旋转中心设为图片的中心点
    CGContextTranslateCTM(context, size.width * 0.5, size.height * 0.5);
    
    // 因为实际的图片有可能大小和预览的图片不同，这里要加上一个扩大因子
    CGFloat factor = size.width / CGRectGetWidth(_holeView.frame);
    CGContextScaleCTM(context, factor, factor);
    CGContextConcatCTM(context, [_gestureHelper makeTransform]);
    CGContextTranslateCTM(context, -size.width * 0.5, -size.height * 0.5);
    
    // 真正的绘画
    UIImage* originImage = _imageView.image;
    CGSize originSize = originImage.size;
    CGRect imgRect = CGRectMake(0, 0, originSize.width, originSize.height);
    imgRect.origin.x = (size.width - originSize.width) * 0.5;
    imgRect.origin.y = (size.height - originSize.height) * 0.5;
    
    [originImage drawInRect:imgRect];
    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

- (IBAction)cutPicDidPressed:(id)sender
{
    UIImage *img = [self resultImageWithSize:CGSizeMake(200, 200)];
    [_delegate PicCutView:self image:img];
    [UIView animateWithDuration:0.4 animations:^(void)
     {
         self.center = CGPointMake(160, 280*3);
     }completion:^(BOOL isFinish)
     {
         [self removeFromSuperview];
     }];
}

@end
