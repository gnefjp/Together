//
//  NetRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetRequest.h"

@implementation NetRequest
@synthesize httpRequest = _httpRequest;


- (void) dealloc
{
    _httpRequest.delegate = nil;
    _httpRequest.downloadProgressDelegate = nil;
    _httpRequest.uploadProgressDelegate = nil;
}


- (id) init
{
    self = [super init];
    if (self)
    {
        _expandVar = [[NSMutableDictionary alloc] init];
    }
    return self;
}


- (ASIHTTPRequest *) _httpRequest
{
    return nil;
}


- (ASIHTTPRequest *) httpRequest
{
    if (_httpRequest == nil)
    {
        _httpRequest = [self _httpRequest];
        _httpRequest.delegate = self;
    }
    
    return _httpRequest;
}


#pragma mark- 子类重写
- (void) _requestFinished
{
}

- (void) _requestFailed
{
}

- (void) _requestUpdateProgress:(CGFloat)progress
{
}


#pragma mark- ASIHTTPRequestDelegate
- (void) requestFinished:(ASIHTTPRequest*)request
{
    NSLog(@"code : %d, msg : %@", request.responseStatusCode, request.responseStatusMessage);
    NSLog(@"http : %@", request.responseString);
    
    _responseData = [HTTPResponse parseFromData:request.responseData];
    NSLog(@"code : %d, msg : %@", _responseData.code, _responseData.msg);
    if (_responseData.success)
    {
        [self _requestFinished];
    }
    else
    {
        [self _requestFailed];
    }
    
    [[NetRequestManager defaultManager] removeRequest:self];
}


- (void) requestFailed:(ASIHTTPRequest*)request
{
    [self _requestFailed];
    [[NetRequestManager defaultManager] removeRequest:self];
}


- (void)setProgress:(float)newProgress
{
    [self _requestUpdateProgress:newProgress];
}

@end



#pragma mark- NetRequestManager
@implementation NetRequestManager

static NetRequestManager* s_defaultManager = nil;
+ (NetRequestManager*) defaultManager
{
    if (s_defaultManager == nil)
    {
        @synchronized(self)
        {
            if (s_defaultManager == nil)
            {
                s_defaultManager = [[self alloc] init];
            }
        }
    }
    
    return s_defaultManager;
}


- (id) init
{
    self = [super init];
    if (self)
    {
        _netRequests = [[NSMutableArray alloc] init];
    }
    return self;
}



- (void) startRequest:(NetRequest*)request
{
    ASIHTTPRequest* httpRequest = request.httpRequest;
    if (httpRequest != nil)
    {
        [httpRequest startAsynchronous];
        [_netRequests addObject:request];
    }
}


- (void) removeRequest:(NetRequest*)request
{
    [_netRequests removeObject:request];
}

@end


#pragma mark- RequestForManager
@implementation NetRequest (ManagerRequest)

- (id) managerDelegate
{
    return [_expandVar objectForKey:@"ManagerDelegate"];
}

- (void) setManagerDelegate:(id)managerDelegate
{
    [_expandVar setValue:managerDelegate forKey:@"ManagerDelegate"];
}


- (UIImage*) loadImage
{
    return [_expandVar objectForKey:@"LoadImage"];
}

- (void) setLoadImage:(UIImage *)loadImage
{
    [_expandVar setValue:loadImage forKey:@"LoadImage"];
}


- (CGFloat) managerProgress
{
    return [_expandVar loadFloat:@"ManagerProgress" defaultValue:0.0];
}

- (void) setManagerProgress:(CGFloat)managerProgress
{
    [_expandVar saveFloat:managerProgress forKey:@"ManagerProgress"];
}

@end




