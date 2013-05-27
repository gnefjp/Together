//
//  GMETLibs+NSObject.h
//  Together
//
//  Created by Gnef_jp on 13-5-8.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

@interface NSObject (GMETLibs)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
