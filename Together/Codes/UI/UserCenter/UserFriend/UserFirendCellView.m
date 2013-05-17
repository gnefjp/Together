//
//  UserFirendCellView.m
//  Together
//
//  Created by APPLE on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserFirendCellView.h"
#import "UserCenterView.h"
#import "GEMTUserManager.h"

@implementation UserFirendCellView
@synthesize isFollow = _isFollow;
@synthesize userInfo = _userInfo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initInfoWithUserInfo:(User_Info*)aUserInfo
                    isFollow:(BOOL)isFollow
{
    if (!_userInfo)
    {
        _userInfo = [[GEMTUserInfo alloc] init];
    }
    [_userInfo setUserInfoWithLoginResPonse:aUserInfo];
    _isFollow = isFollow;
    _iNIckName.text = _userInfo.nickName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        UserCenterView *uView = [UserCenterView loadFromNib];
        [uView viewUserInfoWithUserId:[NSString stringWithFormat:@"%@",_userInfo.userId]];
        [self.superview.superview addSubview:uView];
        uView.center = CGPointMake(160*3,274);
        [UIView animateWithDuration:0.4 animations:^(void)
         {
             uView.center = CGPointMake(160,274);
         }];
    }
}


@end
