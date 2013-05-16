//
//  NetRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#import "const.h"
#import "Response.pb.h"

#pragma mark- Request
@interface NetRequest : NSObject
{
    NSMutableDictionary     *_expandVar;
    ASIHTTPRequest          *_httpRequest;
}

@property (nonatomic, weak)     id               delegate;
@property (nonatomic, weak)     id               managerDelegate;
@property (nonatomic, readonly) ASIHTTPRequest  *httpRequest;
@property (nonatomic, readonly) HTTPResponse    *responseData;

@property (readonly, nonatomic) NSString        *requestUrl;
@property (readonly, nonatomic) NSString        *actionCode;

@end


@interface NetRequest (ProtectedFunction)

- (void) _requestFinished;
- (void) _requestFailed;
- (void) _requestUpdateProgress:(CGFloat)progress;

@end



#pragma mark- NetRequestManager
@interface NetRequestManager : NSObject
{
    NSMutableArray* _netRequests;
}

+ (NetRequestManager*) defaultManager;

- (void) startRequest:(NetRequest*)request;
- (void) removeRequest:(NetRequest*)request;

@end
