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
    return [NSString stringWithFormat:@"http://%@:%@/download", kServerAddr, kFilePort];
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
    if (request.responseStatusCode == 200)
    {
        [self _requestFinished];
    }
    
    [[NetRequestManager defaultManager] removeRequest:self];
}

@end
