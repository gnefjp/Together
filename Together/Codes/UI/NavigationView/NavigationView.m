//
//  NavigationView.m
//  Together
//
//  Created by Gnef_jp on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NavigationView.h"

@implementation NavigationView

- (void) awakeFromNib
{
    
}


- (IBAction)showNavigationBtnPressed:(id)sender
{
    [_delegate NavigationViewShowBtnPressed:self];
}
@end
