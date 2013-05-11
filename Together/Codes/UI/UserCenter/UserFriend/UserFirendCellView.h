//
//  UserFirendCellView.h
//  Together
//
//  Created by APPLE on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.pb.h"
#import "GEMTUserInfo.h"
@interface UserFirendCellView : UITableViewCell
{
    __weak IBOutlet UIImageView *_iAvataImg;
    __weak IBOutlet UILabel     *_iNIckName;
    GEMTUserInfo                *_userInfo;
    BOOL                        _isFollow;
}

@property (strong ,nonatomic) GEMTUserInfo       *userInfo;
@property (nonatomic)         BOOL               isFollow;


- (void)initInfoWithUserInfo:(User_Info*)userInfo
                    isFollow:(BOOL)isFollow;

@end
