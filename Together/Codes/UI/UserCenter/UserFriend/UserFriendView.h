//
//  UserFriendView.h
//  Together
//
//  Created by APPLE on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "UserFollowList.h"

@interface UserFriendView : UIView<UITableViewDelegate,UITableViewDataSource,NetUserRequestDelegate>
{
    __weak IBOutlet UILabel             *_iTitleLb;
    __weak IBOutlet UITableView         *_iFriendTable;
    NSMutableArray                      *_dataArr;
}


@end
