//
//  UserFriendView.m
//  Together
//
//  Created by APPLE on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserFriendView.h"
#import "UserFirendCellView.h"
#import "GEMTUserInfo.h"
#import "UserUnFollowRequest.h"
#import "UserFansList.h"

@implementation UserFriendView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)NetUserRequestSuccess:(NetUserRequest *)request
{
    _dataArr = [[NSMutableArray alloc] init];
    NSArray *arr;
    if ([request isKindOfClass:[UserFollowList class]])
    {
        arr =
        request.responseData.followListResponse.peopleList.userDetailListList;
        
    }
    else if ([request isKindOfClass:[UserFansList class]])
    {
        arr =
        request.responseData.followedListResponse.peopleList.userDetailListList;
    }
    [_dataArr addObjectsFromArray:arr];
    [_iFriendTable reloadData];
}

- (void)NetUserRequestFail:(NetUserRequest *)request
{
    
}

- (void)awakeFromNib
{
    _iFriendTable.delegate = self;
    _iFriendTable.dataSource = self;
}

- (void)initWithFolloUserId:(NSString*)userId
{
    UserFollowList *followList = [[UserFollowList alloc] init];
    followList.delegate = self;
    followList.requestUserId = userId;
    [[NetRequestManager defaultManager] startRequest:followList];
    _iTitleLb.text = @"关注";
}

- (void)initWithFanSUserId:(NSString*)userId
{
    UserFansList *fansList = [[UserFansList alloc] init];
    fansList.delegate = self;
    fansList.fansUserId = userId;
    [[NetRequestManager defaultManager] startRequest:fansList];
    _iTitleLb.text = @"粉丝";
}

- (IBAction)closeBtnDidPressed:(id)sender
{
    self.center = CGPointMake(160,274);
    [UIView animateWithDuration:0.4 animations:^(void)
     {
         self.center = CGPointMake(160*3,274);
     }completion:^(BOOL isFinished)
     {
         [self removeFromSuperview];
     }];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return _dataArr.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserFirendCellView *friendCellView = [tableView dequeueReusableCellWithIdentifier:@"friendCell"];
    if (!friendCellView) {
        friendCellView = [UserFirendCellView loadFromNib];
    }
    DetailResponse *detail = [_dataArr objectAtIndex:indexPath.row];
    [friendCellView initInfoWithUserInfo:detail.userInfo isFollow:detail.isFollow];
    
    return friendCellView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
}

@end
