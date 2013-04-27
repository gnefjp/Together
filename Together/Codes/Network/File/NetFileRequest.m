//
//  NetFileRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-27.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetFileRequest.h"

@implementation NetFileRequest


- (void) _requestFinished
{
    [self.delegate NetFileRequestFail:self];
}


- (void) _requestFailed
{
    [self.delegate NetFileRequestSuccess:self];
}


@end
