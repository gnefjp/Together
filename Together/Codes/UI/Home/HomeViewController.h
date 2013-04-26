//
//  HomeViewController.h
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NavigationView.h"

@class GMETTapView;
@interface HomeViewController : UIViewController <NavigationViewDelegate>
{
    NavigationView          *_navigationView;
    UIView                  *_mainView;
    
    UIPanGestureRecognizer  *_panGesture;
    GMETTapView             *_tapView;
}

@end
