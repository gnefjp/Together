//
//  NavigationView.h
//  Together
//
//  Created by Gnef_jp on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//


#import "UserCenterView.h"

typedef enum
{
    ModulType_RoomList      = 0,
    ModulType_Match         = 1,
    ModulType_UserCenter    = 2,
    ModulType_MyRoom        = 3,
    ModulType_Fans          = 4,
    ModulType_Follow        = 5,
    ModulType_Ranking       = 6,
    ModulType_Notice        = 7,
    
    ModulType_Max           = 8,
} ModulType;   


@class NavigationView;
@protocol NavigationViewDelegate <NSObject>
- (void) NavigationView:(NavigationView *)navigationView
    wantInModulWithType:(ModulType)modulType;
@end

@interface NavigationView : UIView

@property (weak, nonatomic) id<NavigationViewDelegate>  delegate;


- (IBAction)modulBtnPressed:(id)sender;

@end
