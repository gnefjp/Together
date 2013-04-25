//
//  NavigationView.m
//  Together
//
//  Created by Gnef_jp on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NavigationView.h"

#define kHomeModul_BtnTag   1000
#define kMatchModul_BtnTag  1001
#define kMineModul_BtnTag   1002

#define kShowNav_BtnTag     2000

@implementation NavigationView

- (void) awakeFromNib
{
    
}


- (IBAction)showNavigationBtnPressed:(id)sender
{
    [_delegate NavigationViewShowBtnPressed:self];
}


- (IBAction)modulBtnPressed:(UIButton*)sender
{
    int type = (sender.tag - kHomeModul_BtnTag);
    [_delegate NavigationView:self wantInModulWithType:type];
}


- (UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIButton* showNavBtn = [self viewWithTag:kShowNav_BtnTag recursive:NO];
    
    if (point.x >= showNavBtn.frameX &&
        !CGRectContainsPoint(showNavBtn.frame, point))
    {
        return nil;
    }
    
    return [super hitTest:point withEvent:event];
}

@end
