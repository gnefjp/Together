//
//  NetFileManager.m
//  Together
//
//  Created by Gnef_jp on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "ImageOperation.h"
#import "NetFileManager.h"


#define kImageCachesNum1    10
#define kImageCachesNum2    100
#define kFileCachesNum      100


//////////////////////////////////////////////////////////////////////////////////////////
@interface ImageCachesInfo : NSObject

@property (copy,   nonatomic) NSString  *fileID;
@property (strong, nonatomic) UIImage   *image;

+ (id) imageCachesInfoWithImage:(UIImage *)image fileID:(NSString *)fileID;
- (id) initWithImage:(UIImage *)image fileID:(NSString *)fileID;

@end

@implementation ImageCachesInfo

+ (id) imageCachesInfoWithImage:(UIImage *)image fileID:(NSString *)fileID
{
    return [[self alloc] initWithImage:image fileID:fileID];
}


- (id) initWithImage:(UIImage *)image fileID:(NSString *)fileID
{
    self = [super init];
    if (self)
    {
        _image = image;
        _fileID = fileID;
    }
    return self;
}

@end

//////////////////////////////////////////////////////////////////////////////////////////
@implementation NetFileManager

static NetFileManager *s_defaultManager = nil;

+ (NetFileManager *) defaultManager
{
    if (s_defaultManager == nil)
    {
        @synchronized(self)
        {
            if (s_defaultManager == nil)
            {
                s_defaultManager = [[self alloc] init];
            }
        }
    }
    
    return s_defaultManager;
}


- (void) dealloc
{
    [_imageOperationQueue cancelAllOperations];
}


- (id) init
{
    self = [super init];
    if (self)
    {
        _imageCaches = [[NSMutableArray alloc] init];
        _imageOperationQueue = [[NSOperationQueue alloc] init];
        _imageOperationItems = [[NSMutableArray alloc] init];
    }
    return self;
}


#pragma mark- NetFileRequestDelegate
- (void) NetFileRequestFail:(NetFileRequest *)request
{
    if ([request.managerDelegate respondsToSelector:@selector(NetFileManagerFail:)])
    {
        [request.managerDelegate NetFileManagerFail:self];
    }
    
    [self _removeRequest:request];
}


- (void) NetFileRequestSuccess:(NetFileRequest *)request
{
    if (request.requestType == NetFileRequestType_Download)
    {
        FileDownloadRequest *downloadRequest = (FileDownloadRequest *)request;
        if (downloadRequest.fileType == FileType_Image)
        {
            [self _addImageOperation:request.httpRequest.responseData userInfo:downloadRequest];
            [_requestList removeObject:downloadRequest];
            return;
        }
        
        if ([request.managerDelegate respondsToSelector:@selector(NetFileManager:fileID:fileData:)])
        {
            [request.managerDelegate NetFileManager:self
                                             fileID:downloadRequest.fileID
                                           fileData:request.httpRequest.responseData];
        }
    }
    
    [self _removeRequest:request];
}


#pragma mark- request
- (void) removeDelegate:(id)delegate
{
    for (NetFileRequest *request in _requestList)
    {
        if (request.managerDelegate == delegate)
        {
            [self _removeRequest:request];
        }
    }
    
    [self _cancelLoadImageWithDelegate:delegate];
}


- (void) _removeRequest:(NetFileRequest *)request
{
    request.managerDelegate = nil;
    [_requestList removeObject:request];
}


- (void) _downloadWithID:(NSString *)fileID fileType:(FileType)fileType delegate:(id)delegate
{
    FileDownloadRequest *request = [[FileDownloadRequest alloc] init];
    request.fileID = fileID;
    request.fileType = fileType;
    request.delegate = self;
    request.managerDelegate = delegate;
    
    [[NetRequestManager defaultManager] startRequest:request];
}


- (BOOL) _insertFileID:(NSString*)fileID atFirstForArray:(NSMutableArray *)array
{
    for (NSString *tmpFileID in array)
    {
        if ([tmpFileID isEqualToString:fileID])
        {
            [array removeObject:tmpFileID];
            [array insertObject:fileID atIndex:0];
            return YES;
        }
    }
    
    [array insertObject:fileID atIndex:0];
    return NO;
}


- (NSData *) _getFileDataWithID:(NSString *)fileID
                            dir:(NSString *)dir
                          array:(NSMutableArray *)array
                         maxNum:(int)maxNum
{
    NSString* filePath = [dir stringByAppendingPathComponent:fileID];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        if (![self _insertFileID:fileID atFirstForArray:array] && array.count > maxNum)
        {
            NSString *tmpFilePath = [dir stringByAppendingPathComponent:[array lastObject]];
            [[NSFileManager defaultManager] removeItemAtPath:tmpFilePath error:nil];
            [array removeLastObject];
        }
        return [NSData dataWithContentsOfFile:filePath];
    }
    
    return nil;
}


- (UIImage *) imageWithFileID:(NSString *)fileID delegate:(id)delegate
{
    for (int i = 0; i < _imageCaches.count; ++i)
    {
        ImageCachesInfo *imageInfo = [_imageCaches objectAtIndex:i];
        if ([imageInfo.fileID isEqualToString:fileID])
        {
            [_imageCaches removeObject:imageInfo];
            [_imageCaches insertObject:imageInfo atIndex:0];
            return imageInfo.image;
        }
    }
    
    NSData* fileData = [self _getFileDataWithID:fileID
                                            dir:[self _imageCachesDirectory]
                                          array:_imageInfoArray
                                         maxNum:kImageCachesNum2];
    if (fileData)
    {
        FileDownloadRequest *request = [[FileDownloadRequest alloc] init];
        request.fileID = fileID;
        request.managerDelegate = delegate;
        [self _addImageOperation:fileData userInfo:request];
    }
    else
    {
        [self _downloadWithID:fileID fileType:FileType_Image delegate:delegate];
    }
    
    return nil;
}


- (NSData *) fileWithID:(NSString *)fileID delegate:(id)delegate
{
    NSData* fileData = [self _getFileDataWithID:fileID
                                            dir:[self _fileCachesDirectory]
                                          array:_fileInfoArray
                                         maxNum:kFileCachesNum];
    
    if (!fileData)
    {
         [self _downloadWithID:fileID fileType:FileType_Other delegate:delegate];
    }
    
    return fileData;
}


#pragma mark- Caches
- (void) removeCaches
{
    [[NSFileManager defaultManager] removeItemAtPath:[self _imageCachesDirectory]
                                               error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:[self _fileCachesDirectory]
                                               error:nil];
    
    [NSFileManager letDirectoryExistsAtPath:[self _imageCachesDirectory]];
    [NSFileManager letDirectoryExistsAtPath:[self _fileCachesDirectory]];
}


- (void) _initCachesInfo
{
    NSString *fileInfoPath = [[self _fileCachesDirectory]
                              stringByAppendingPathComponent:@"FileInfos.plist"];
    _fileInfoArray = [NSMutableArray arrayWithContentsOfFile:fileInfoPath];
    
    NSString *imageInfoPath = [[self _imageCachesDirectory]
                               stringByAppendingPathComponent:@"FileInfos.plist"];
    _imageInfoArray = [NSMutableArray arrayWithContentsOfFile:imageInfoPath];
}


- (void) saveCaches
{
    NSString *fileInfoPath = [[self _fileCachesDirectory]
                              stringByAppendingPathComponent:@"FileInfos.plist"];
    [_fileInfoArray writeToFile:fileInfoPath atomically:YES];
    
    NSString *imageInfoPath = [[self _imageCachesDirectory]
                               stringByAppendingPathComponent:@"FileInfos.plist"];
    [_imageInfoArray writeToFile:imageInfoPath atomically:YES];
}


- (void) _cachesFile:(NSData *)fileData withFileID:(NSString *)fileID
{
    if (_fileInfoArray.count > kFileCachesNum)
    {
        NSString *filePath = [[self _fileCachesDirectory]
                              stringByAppendingPathComponent:[_fileInfoArray lastObject]];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        [_fileInfoArray removeLastObject];
    }
    
    NSString *filePath = [[self _fileCachesDirectory] stringByAppendingPathComponent:fileID];
    [fileData writeToFile:filePath atomically:YES];
    [_fileInfoArray insertObject:fileID atIndex:0];
}


- (void) _cachesImageWithData:(NSData *)imageData withFileID:(NSString *)fileID
{
    if (_imageInfoArray.count > kImageCachesNum2)
    {
        NSString *filePath = [[self _imageCachesDirectory]
                              stringByAppendingPathComponent:[_imageInfoArray lastObject]];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        [_imageInfoArray removeLastObject];
    }
    
    NSString *filePath = [[self _imageCachesDirectory] stringByAppendingPathComponent:fileID];
    [imageData writeToFile:filePath atomically:YES];
    [_imageInfoArray insertObject:fileID atIndex:0];
}


- (void) _cachesImage:(UIImage *)image withFileID:(NSString *)fileID
{
    ImageCachesInfo *imageCachesInfo = [ImageCachesInfo imageCachesInfoWithImage:image fileID:fileID];
    
    if (_imageCaches.count > kImageCachesNum1)
    {
        [_imageCaches removeLastObject];
    }
    
    [_imageCaches insertObject:imageCachesInfo atIndex:0];
}


- (NSString *) _imageCachesDirectory
{
    return [[NSFileManager cachesPath] stringByAppendingPathComponent:@"ImageCaches"];
}


- (NSString *) _fileCachesDirectory
{
    return [[NSFileManager cachesPath] stringByAppendingPathComponent:@"FileCaches"];
}


#pragma mark- Image
- (void) _cancelLoadImageWithDelegate:(id)delegate
{
    for (int i = 0; i < _imageOperationItems.count; ++i)
    {
        ImageOperationItem *item = [_imageOperationItems objectAtIndex:i];
        if ([item.userInfo isKindOfClass:[FileDownloadRequest class]])
        {
            FileDownloadRequest *request = (FileDownloadRequest *)item.userInfo;
            if (request.managerDelegate == delegate)
            {
                [self _removeImageOperationItem:item];
                --i;
            }
        }
    }
}


- (void) _removeImageOperationItem:(ImageOperationItem *)item
{
    item.imageOperation.delegate = nil;
    [item.imageOperation cancel];
    item.delegate = nil;
    [_imageOperationItems removeObject:item];
}


- (void) _addImageOperation:(NSData *)imageData userInfo:(id)userInfo
{
    ImageOperationItem* item = [ImageOperationItem itemWithData:imageData delegate:self userInfo:userInfo];
    [_imageOperationQueue addOperation:item.imageOperation];
    [_imageOperationItems addObject:item];
}


#pragma mark- ImageOperationItemDelegate
- (void) ImageOperationItem:(ImageOperationItem *)item didLoadImage:(UIImage *)image userInfo:(id)userInfo
{
    if (image && [userInfo isKindOfClass:[FileDownloadRequest class]])
    {
        FileDownloadRequest *request = (FileDownloadRequest *)userInfo;
        [self _cachesImage:image withFileID:request.fileID];
        if ([request.managerDelegate respondsToSelector:@selector(NetFileManager:fileID:image:)])
        {
            [request.managerDelegate NetFileManager:self fileID:request.fileID image:image];
        }
    }
    [self _removeImageOperationItem:item];
}


- (void) ImageOperationItemFailLoadImage:(ImageOperationItem *)item
{
    [self _removeImageOperationItem:item];
}

@end
