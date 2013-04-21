//
//  NavigationView.h
//  Together
//
//  Created by Gnef_jp on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//


typedef enum
{
    ModulType_RoomList      = 0,
    
} ModulType;

@class NavigationView;
@protocol NavigationViewDelegate <NSObject>
- (void) NavigationView:(NavigationView *)navigationView wantInModulWithType:(ModulType)modulType;
- (void) NavigationViewShowBtnPressed:(NavigationView *)navigationView;
@end

@interface NavigationView : UIView

@property (weak, nonatomic) id<NavigationViewDelegate>  delegate;

- (IBAction)showNavigationBtnPressed:(id)sender;
@end
