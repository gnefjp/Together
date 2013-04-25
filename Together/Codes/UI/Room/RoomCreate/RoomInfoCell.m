//
//  RoomInfoCell.m
//  Together
//
//  Created by Gnef_jp on 13-4-25.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomInfoCell.h"

@implementation RoomInfoCell


- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    _titleLabel.textColor = highlighted ? [UIColor whiteColor] : [UIColor blackColor];
    _contentLabel.textColor = highlighted ? [UIColor whiteColor] : GMETColorRGBMake(157, 157, 157);
    
    [super setHighlighted:highlighted animated:animated];
}


- (IBAction)changeBtnPressed:(id)sender
{
    
}
@end
