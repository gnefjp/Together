//
//  JoinPersonView.h
//  Together
//
//  Created by Gnef_jp on 13-5-15.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RoomGetJoinPersonsRequest.h"

@class NetRoomItem;
@class NetUserList;
@interface JoinPersonView : UIView <NetRoomRequestDelegate>
{
    __weak IBOutlet UIButton    *_reloadBtn;
}

@property (strong, nonatomic) NetUserList                       *userList;
@property (strong, nonatomic) NetRoomItem                       *roomItem;
@property (weak,   nonatomic) IBOutlet UIScrollView             *joinPersonsScrollView;
@property (weak,   nonatomic) IBOutlet UIActivityIndicatorView  *loadingActivityIndicator;

- (IBAction)showMoreJoinPerson:(id)sender;
- (IBAction)reloadDidPressed:(id)sender;

- (void) reloadData;

@end
