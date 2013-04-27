//
//  FileDownloadRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-27.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetFileRequest.h"

@interface FileDownloadRequest : NetFileRequest

@property (strong, nonatomic) NSString *fileID;

@end
