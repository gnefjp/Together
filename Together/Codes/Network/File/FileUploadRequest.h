//
//  FileUploadRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-27.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetFileRequest.h"

@interface FileUploadRequest : NetFileRequest

@property (strong, nonatomic) NSString  *filePath;
@property (strong, nonatomic) NSString  *userID;
@property (strong, nonatomic) NSString  *sid;

@end
