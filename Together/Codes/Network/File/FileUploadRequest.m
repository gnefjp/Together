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
    return @"http://192.168.1.21:9081";
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
        [request addPostValue:[self.filePath pathExtension] forKey:@"suffix"];
        fileData = [NSData dataWithContentsOfFile:_filePath];
    }
    else
    {
        [request addPostValue:@".png" forKey:@"suffix"];
        fileData = UIImagePNGRepresentation(_image);
    }
    
    [request addPostValue:[[NSString md5FromData:fileData] lowercaseString] forKey:@"md5"];
    NSString *fileDataStr = [GTMBase64 stringByEncodingData:fileData];
    NSLog(@"---------------------------------");
    NSLog(@"%@",fileDataStr);
    NSLog(@"---------------------------------");
    [request addPostValue:fileDataStr forKey:@"filedata"];
    
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
}

@end
