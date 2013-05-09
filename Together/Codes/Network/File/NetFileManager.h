//
//  NetFileManager.h
//  Together
//
//  Created by Gnef_jp on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "FileDownloadRequest.h"

@class NetFileManager;
@protocol NetFileManagerDelegate <NSObject>
- (void) NetFileManager:(NetFileManager *)fileManager fileID:(NSString *)fileID image:(UIImage *)image;
- (void) NetFileManager:(NetFileManager *)fileManager fileID:(NSString *)fileID fileData:(NSData *)fileData;
@end

@interface NetFileManager : NSObject <ImageOperationItemDelegate, NetFileRequestDelegate>
{
    NSMutableArray      *_requestList;
    
    NSMutableArray      *_fileInfoArray;
    NSMutableArray      *_imageInfoArray;
    
    NSMutableArray      *_imageCaches;
    NSMutableArray      *_imageOperationItems;
    NSOperationQueue    *_imageOperationQueue;
}

+ (NetFileManager *) defaultManager;

- (void) removeDelegate:(id)delegate;
- (void) removeCaches;
- (void) saveCaches;

- (UIImage *) imageWithFileID:(NSString *)fileID delegate:(id)delegate;
- (NSData *) fileWithID:(NSString *)fileID delegate:(id)delegate;

@end
