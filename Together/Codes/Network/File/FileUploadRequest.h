//
//  FileUploadRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-27.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetFileRequest.h"

@interface FileUploadRequest : NetFileRequest

@property (strong, nonatomic) UIImage   *image;

@property (copy,   nonatomic) NSString  *filePath;
@property (copy,   nonatomic) NSString  *userID;
@property (copy,   nonatomic) NSString  *sid;

@property (readonly,nonatomic) NSString *fileID;

@end
