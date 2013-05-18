//
//  AsyncSocketUpload.h
//  Together
//
//  Created by APPLE on 13-5-18.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@class AsyncSocketUpload;

@protocol AsyncSocketUploadDelegate <NSObject>

- (void)AsyncSocketUploadSuccess:(AsyncSocketUpload*)uploadObject;
- (void)AsyncSocketUploadFail:(AsyncSocketUpload*)uploadObject;

@end

@interface AsyncSocketUpload : NSObject
{
      GCDAsyncSocket                                 *socket;
      __weak id<AsyncSocketUploadDelegate>           _delegate;
}

@property (strong, nonatomic) UIImage   *image;

@property (copy, nonatomic) NSString    *filePath;
@property (copy, nonatomic) NSString    *userID;
@property (copy, nonatomic) NSString    *sid;

@property (assign, nonatomic) NSInteger requestCount;
@property (copy,nonatomic) NSString     *fileID;

@property (weak,  nonatomic) id<AsyncSocketUploadDelegate>           delegate;

- (void)starRequest;
@end
