//
//  NetRequest.h
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#pragma mark- Request
@interface NetRequest : NSObject
{
    NSMutableDictionary     *_expandVar;
}

@property (nonatomic, assign) id                delegate;
@property (nonatomic, readonly) ASIHTTPRequest  *httpRequest;

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



#pragma mark- RequestForManager
@interface NetRequest (ManagerRequest)

@property (nonatomic, assign) id                managerDelegate;
@property (nonatomic, retain) UIImage*          loadImage;
@property (nonatomic, assign) CGFloat           managerProgress;
@property (nonatomic, retain) NSDictionary*     dataInfo;
@property (nonatomic, assign) NSInteger         code;
@property (nonatomic, retain) NSString*         msg;

@end
