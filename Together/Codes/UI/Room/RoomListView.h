//
//  RoomListView.h
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomGridView.h"

@class RoomListView;
@protocol RoomListViewDelegate <NSObject>
- (void) RoomListViewShowNavigation:(RoomListView *)roomListView;
@end


@interface RoomListView : UIView
{
    __weak id<RoomListViewDelegate>     _delegate;
}

@property (weak,   nonatomic) id            delegate;
@property (strong, nonatomic) RoomGridView  *roomGrid;

- (IBAction)showNavigationDidPressed:(id)sender;
- (IBAction)createRoomBtnPressed:(id)sender;

@end
