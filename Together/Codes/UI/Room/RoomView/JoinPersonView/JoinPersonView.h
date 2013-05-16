//
//  JoinPersonView.h
//  Together
//
//  Created by Gnef_jp on 13-5-15.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RoomGetJoinPersonsRequest.h"

@class NetItemList;
@interface JoinPersonView : UIView <NetRoomRequestDelegate>
{
    __weak IBOutlet UIButton    *_reloadBtn;
    
    NetItemList                 *_userList;
}

@property (copy, nonatomic) NSString                            *roomID;
@property (weak, nonatomic) IBOutlet UIScrollView               *joinPersonsScrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView    *loadingActivityIndicator;

- (IBAction)showMoreJoinPerson:(id)sender;
- (IBAction)reloadDidPressed:(id)sender;

@end
