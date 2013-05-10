//
//  ImageOperation.m
//  Together
//
//  Created by Gnef_jp on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "ImageOperation.h"

#pragma mark- ImageOperationItem
@implementation ImageOperationItem

+ (id) itemWithData:(NSData *)imageData
           delegate:(id<ImageOperationItemDelegate>)delegate
           userInfo:(id)userInfo
{
    return [[self alloc] initWithData:imageData delegate:delegate userInfo:userInfo];
}


- (id) initWithData:(NSData *)imageData
           delegate:(id<ImageOperationItemDelegate>)delegate
           userInfo:(id)userInfo
{
    self = [super init];
    if (self)
    {
        _imageOperation = [ImageOperation imageOperationWithData:imageData
                                                        delegate:self];
        _delegate = delegate;
        _userInfo = userInfo;
    }
    return self;
}


- (void) cancel
{
    _imageOperation.delegate = nil;
    [_imageOperation cancel];
    _delegate = nil;
}


#pragma mark- backToMainThread
- (void) _loadImageWithImage:(UIImage *)image
{
    if (image)
    {
        [_delegate ImageOperationItem:self didLoadImage:image userInfo:_userInfo];
    }
    else
    {
        [_delegate ImageOperationItemFailLoadImage:self];
    }
}


#pragma mark- ImageOperationDelegate
- (void) ImageOperation:(ImageOperation *)imageOperation didLoadImage:(UIImage *)image
{
    [self performSelectorOnMainThread:@selector(_loadImageWithImage:) withObject:image waitUntilDone:NO];
}

@end


#pragma mark- ImageOperation
@implementation ImageOperation
+ (id) imageOperationWithData:(NSData *)imageData delegate:(id<ImageOperationDelegate>)delegate
{
    return [[self alloc] initWithData:imageData delegate:delegate];
}


- (id) initWithData:(NSData *)imageData delegate:(id<ImageOperationDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _imageData = imageData;
        _delegate = delegate;
    }
    return self;
}


-(void)main
{
	@autoreleasepool
    {
        UIImage *image = [UIImage imageWithData:_imageData];
        
        image = [image transToBitmapImage];
        if (![self isCancelled])
        {
            if([_delegate respondsToSelector:@selector(ImageOperation:didLoadImage:)])
            {
                [_delegate ImageOperation:self didLoadImage:image];
            }
        }
    }
}

@end
