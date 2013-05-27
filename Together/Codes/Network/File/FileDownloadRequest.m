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
#ifdef kIsSimulatedData
    if (_fileType == FileType_Image)
    {
        return @"http://127.0.0.1/File/Download/Image";
    }
    else
    {
        return @"http://127.0.0.1/File/Download/Sound";
    }
#endif
    return [NSString stringWithFormat:@"http://%@:%@/download", kServerAddr, kDownloadPort];
}


- (ASIHTTPRequest *) _httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?fileId=%@", self.requestUrl, _fileID];
    NSURL* url = [NSURL URLWithString:urlStr];
    
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
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
