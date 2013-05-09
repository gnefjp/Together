//
//  FileDownloadRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-27.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "FileDownloadRequest.h"

@implementation FileDownloadRequest

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetFileRequestType_Download;
    }
    return self;
}


- (NSString *) requestUrl
{
    return @"http://192.168.1.150:9080/download";
}


- (ASIHTTPRequest *) _httpRequest
{
    NSURL* url = [NSURL URLWithString:self.requestUrl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    NSLog(@"_fileID : %@", _fileID);
    [request addPostValue:_fileID forKey:@"fileId"];
    
    return request;
}


- (void) requestFinished:(ASIHTTPRequest*)request
{
    NSLog(@"request.responseStatusCode : %d", request.responseStatusCode);
    if (request.responseStatusCode == 200)
    {
        [self _requestFinished];
    }
}

@end
