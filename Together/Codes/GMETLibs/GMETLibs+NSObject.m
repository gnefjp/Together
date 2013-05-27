//
//  GMETLibs+NSObject.m
//  Together
//
//  Created by Gnef_jp on 13-5-8.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GMETLibs+NSObject.h"

@implementation NSObject (GMETLibs)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    block = [block copy];
    [self performSelector:@selector(_fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}


- (void)_fireBlockAfterDelay:(void (^)(void))block
{
    block();
}

@end
