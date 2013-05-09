//
//  FileUploadRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-27.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "FileUploadRequest.h"

@implementation FileUploadRequest

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetFileRequestType_Upload;
    }
    return self;
}


- (ASIHTTPRequest *) _httpRequest
{
    NSURL* url = [NSURL URLWithString:self.requestUrl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.sid forKey:@"sid"];
    [request addPostValue:self.userID forKey:@"uid"];
    
    return request;
}


- (void) _requestFinished
{
    // TODO: 上传成功
    
}

@end
