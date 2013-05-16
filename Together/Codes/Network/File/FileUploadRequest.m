//
//  FileUploadRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-27.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "GTMBase64.h"

#import "FileUploadRequest.h"

@implementation FileUploadRequest


- (NSString *) requestUrl
{
    return [NSString stringWithFormat:@"http://%@:%@", kServerAddr, kFilePort];
}


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
    
    NSData *fileData = nil;
    if (_image == nil)
    {
        [request addPostValue:[NSString stringWithFormat:@".%@", [self.filePath pathExtension]]
                       forKey:@"suffix"];
        fileData = [NSData dataWithContentsOfFile:_filePath];
    }
    else
    {
        [request addPostValue:@".png" forKey:@"suffix"];
        fileData = UIImagePNGRepresentation(_image);
    }
    
    [request addPostValue:[[NSString md5FromData:fileData] lowercaseString] forKey:@"md5"];
//    NSString *fileDataStr = [GTMBase64 stringByEncodingData:fileData];
//    [request addPostValue:fileDataStr forKey:@"filedata"];
    [request addData:fileData forKey:@"filedata"];
    
    return request;
}


- (void) requestFinished:(ASIHTTPRequest*)request
{
    if (request.responseStatusCode == 200)
    {
        _fileID = request.responseString;
        NSLog(@"fileID : %@", _fileID);
        [self _requestFinished];
    }
    else
    {
        [self _requestFailed];
    }   
    
    [[NetRequestManager defaultManager] removeRequest:self];
}


- (void) _requestFailed
{
    if (self.requestCount < 4)
    {
        FileUploadRequest *tmpRequest = [[FileUploadRequest alloc] init];
        tmpRequest.image = self.image;
        tmpRequest.filePath = self.filePath;
        tmpRequest.userID = self.userID;
        tmpRequest.sid = self.sid;
        tmpRequest.delegate = self.delegate;
        tmpRequest.requestCount = self.requestCount + 1;
        
        [[NetRequestManager defaultManager] startRequest:tmpRequest];
    }
    else
    {
        NSLog(@"self.delegate : %@", self.delegate);
        [self.delegate NetFileRequestFail:self];
    }
}

@end
