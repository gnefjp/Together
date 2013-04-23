//
//  AvatarCutView.m
//  Together
//
//  Created by APPLE on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "AvatarCutView.h"

@interface AvatarCutView()
- (IBAction)_canCelBtnDidPressed:(id)sender;

- (IBAction)_submitBtnDidPressed:(id)sender;
@end

@implementation AvatarCutView
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    _cropImageView = [[KICropImageView alloc] initWithFrame:self.bounds];
    [_cropImageView setCropSize:CGSizeMake(200, 200)];
}

- (void)initWithImage:(UIImage*)img
{
    [_cropImageView setImage:img];
}

- (IBAction)_canCelBtnDidPressed:(id)sender
{
    [self hideAnimation];
}

- (void)showAnimation
{
     self.center = CGPointMake(160, 384*3);
    [UIView animateWithDuration:0.4 animations:^(void)
     {
         self.center = CGPointMake(160, 384);
     }completion:^(BOOL isFinished)
     {
         [self removeFromSuperview];
     }];
}

- (void)hideAnimation
{
    [UIView animateWithDuration:0.4 animations:^(void)
     {
         self.center = CGPointMake(160, 384*3);
     }completion:^(BOOL isFinished)
     {
         [self removeFromSuperview];
     }];
}

- (IBAction)_submitBtnDidPressed:(id)sender
{
     NSData *data = UIImagePNGRepresentation([_cropImageView cropImage]);
    [_delegate avataImageDidReceive:[UIImage imageWithData:data]];
    [self hideAnimation];
}
@end
