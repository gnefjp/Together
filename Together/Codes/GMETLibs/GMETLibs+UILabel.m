//
//  GMETLibs+UILabel.m
//  Together
//
//  Created by Gnef_jp on 13-5-15.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GMETLibs+UILabel.h"

@implementation UILabel (GMETLibs)


- (void) changeFrameWithText
{
    CGSize size = [self.text sizeWithFont:self.font
                        constrainedToSize:CGSizeMake(20000, self.frame.size.height)
                            lineBreakMode:self.lineBreakMode];
    NSLog(@"size.width : %lf", size.width);
    
    CGRect frame = self.frame;
    frame.size.width = size.width;
    self.frame = frame;
}


@end
