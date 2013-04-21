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
    switch (sender.tag-1000) {
        case ModulType_RoomList:
            
            break;
        case ModulType_Match:
            
            break;
        case ModulType_Mine:
            [self _dealWithUserCenterBtnDidpressed];
            break;
        case ModulType_MyRoom:
            
            break;
        case ModulType_Fans:
            break;
        case ModulType_Follow:
            break;
        case ModulType_Ranking:
            break;
        case ModulType_Notice:
            break;
        case ModulType_Max:
            break;
        default:
            break;
    }
}

- (void)_dealWithUserCenterBtnDidpressed
{
    
}

@end
