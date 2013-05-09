//
//  FileDownloadRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-27.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetFileRequest.h"

typedef enum
{
    FileType_Image  = 0,
    FileType_Other  = 1,
    
    FileType_Max    = 2,
} FileType;

@interface FileDownloadRequest : NetFileRequest

@property (strong, nonatomic) NSString *fileID;
@property (assign, nonatomic) BOOL      fileType;

@end
