//
//  AsyncSocketUpload.m
//  Together
//
//  Created by APPLE on 13-5-18.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "AsyncSocketUpload.h"
#import "GTMBase64.h"

@implementation AsyncSocketUpload
@synthesize image = _image;
@synthesize userID = _userID;
@synthesize sid = _sid;
@synthesize fileID = _fileID;
@synthesize filePath = _filePath;
@synthesize requestCount = _requestCount;
@synthesize delegate = _delegate;

- (void) dealloc
{
    socket.delegate = nil;
    socket = nil;
}

- (NSMutableDictionary*)_getRequestDict
{
    NSData *fileData = nil;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (_image == nil)
    {
        [dict setValue:[NSString stringWithFormat:@".%@", [self.filePath pathExtension]]
                forKey:@"suffix"];
        fileData = [NSData dataWithContentsOfFile:_filePath];
    }
    else
    {
        [dict setValue:@".png" forKey:@"suffix"];
        fileData = UIImagePNGRepresentation(_image);
    }
    NSString *fileDataStr = [GTMBase64 stringByEncodingData:fileData];
    
    [dict setValue:fileDataStr forKey:@"filedata"];
    [dict setValue:self.sid forKey:@"sid"];
    [dict setValue:self.userID forKey:@"uid"];
    [dict setValue:[[NSString md5FromData:fileData] lowercaseString] forKey:@"md5"];
    return dict;
}

- (NSString*)requestUrl
{
#ifdef kIsSimulatedData
    return @"http://127.0.0.1/File/Upload";
#endif
    return [NSString stringWithFormat:@"http://%@:%@", kServerAddr, kFilePort];
}

- (void)starRequest
{
//    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",
//                        [self requestUrl],
//                        [NSString urlArgsStringFromDictionary:[self _getRequestDict]]];
    
    NSString *urlStr = [NSString urlArgsStringFromDictionary:[self _getRequestDict]];
    socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    if(![socket connectToHost:kServerAddr onPort:[kFilePort intValue] error:nil])
    {
        NSLog(@"connect failed");
    }else
    {
        NSLog(@"connect ok");
        NSString *aTemp = [NSString stringWithFormat:@"length=&"];
        NSLog(@"length:%d",aTemp.length);
        NSLog(@"length:%d",urlStr.length);
        
        int length = aTemp.length + [urlStr length];
        NSString *lengthStr = [NSString stringWithFormat:@"%d",length];
        NSString *lengthStr2 = [NSString stringWithFormat:@"%d",length+lengthStr.length];
        int totalLength = lengthStr2.length +length;
        NSString *postStr = [NSString stringWithFormat:@"length=%d&%@",totalLength,urlStr];
        NSLog(@"length:%d",postStr.length);
        
        [socket writeData:[postStr dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
        [socket readDataWithTimeout:-1 tag:0];
    }
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *newMessage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"newMessage :%@",newMessage);
    [socket readDataWithTimeout:-1 tag:0];
    if ([newMessage length] != 0)
    {
        NSRange range=[newMessage rangeOfString:@"200"];
        if(range.location!=NSNotFound)
        {
            NSArray *arr = [newMessage componentsSeparatedByString:@"\n"];
            self.fileID = [arr lastObject];
            [_delegate AsyncSocketUploadSuccess:self];
        }else
        {
            
            [_delegate AsyncSocketUploadFail:self];
        }
    }
}

-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    [socket readDataWithTimeout:-1 tag:0];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    
}
@end
