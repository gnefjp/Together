//
//  ImageOperation.h
//  Together
//
//  Created by Gnef_jp on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageOperation;
@protocol ImageOperationDelegate <NSObject>
- (void) ImageOperation:(ImageOperation *)imageOperation didLoadImage:(UIImage *)image;
@end


@class ImageOperationItem;
@protocol ImageOperationItemDelegate <NSObject>
- (void) ImageOperationItem:(ImageOperationItem *)item didLoadImage:(UIImage *)image userInfo:(id)userInfo;
- (void) ImageOperationItemFailLoadImage:(ImageOperationItem *)item;
@end


#pragma mark- OperationItem
@interface ImageOperationItem : NSObject <ImageOperationDelegate>

@property (weak,   nonatomic) id<ImageOperationItemDelegate>    delegate;
@property (strong, nonatomic) ImageOperation                    *imageOperation;
@property (strong, nonatomic) id                                userInfo;

+ (id) itemWithData:(NSData *)imageData
           delegate:(id<ImageOperationItemDelegate>)delegate
           userInfo:(id)userInfo;

- (id) initWithData:(NSData *)imageData
           delegate:(id<ImageOperationItemDelegate>)delegate
           userInfo:(id)userInfo;

- (void) cancel;

@end



#pragma mark- Operation
@interface ImageOperation : NSOperation

@property (weak,  nonatomic) id<ImageOperationDelegate>     delegate;
@property (strong,nonatomic) NSData                         *imageData;

+ (id) imageOperationWithData:(NSData *)imageData delegate:(id<ImageOperationDelegate>)delegate;
- (id) initWithData:(NSData *)imageData delegate:(id<ImageOperationDelegate>)delegate;

@end
