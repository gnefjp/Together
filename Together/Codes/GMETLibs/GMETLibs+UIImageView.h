//
//  GMETLibs+UIImageView.h
//  Together
//
//  Created by Gnef_jp on 13-5-8.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark- UIImageView
@interface UIImageView(GMETLibs)

- (void) setImage:(UIImage *)image animation:(BOOL)animation;

@end



#pragma mark- UIImage
@interface UIImage(GMETLibs)

- (UIImage*) transToBitmapImage;
- (UIImage*) transToBitmapImageWithSize:(CGSize)size;

@end