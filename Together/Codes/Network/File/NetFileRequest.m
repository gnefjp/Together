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
    [self.delegate NetFileRequestSuccess:self];
}


- (void) _requestFailed
{
    [self.delegate NetFileRequestFail:self];
}


@end
