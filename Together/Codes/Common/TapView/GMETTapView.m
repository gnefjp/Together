//
//  GMETTapView.m
//  Together
//
//  Created by Gnef_jp on 13-4-25.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GMETTapView.h"

@implementation GMETTapView

@synthesize delegate = _delegate;

- (id) init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


#pragma mark- TouchesDelegate
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isIgnoreTap)
    {
        return;
    }
    
    if ([_delegate respondsToSelector:@selector(GMETTapView:touchBegin:)])
    {
        [_delegate GMETTapView:self touchBegin:event];
    }
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isIgnoreTap)
    {
        return;
    }
    
    if ([_delegate respondsToSelector:@selector(GMETTapView:touchEnded:)])
    {
        [_delegate GMETTapView:self touchEnded:event];
    }
}


- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end
