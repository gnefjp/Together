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
#import "UserUnFollowList.h"

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
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    NSArray *arr =
    request.responseData.followedListResponse.peopleList.userInfoList;
    BOOL isEnd = request.responseData.followListResponse.peopleList.isEnd;
    NSLog(@"%d",isEnd);
    for (int i = 0 ; i<arr.count; i++)
    {
        GEMTUserInfo *userinfo = [[GEMTUserInfo alloc] init];
        [userinfo setUserInfoWithLoginResPonse:[arr objectAtIndex:i]];
        [dataArr addObject:userinfo];
    }
    [_iFriendTable reloadData];
}

- (void)NetUserRequestFail:(NetUserRequest *)request
{
    
}

- (void)awakeFromNib
{
    _iFriendTable.delegate = self;
    _iFriendTable.dataSource = self;
    UserUnFollowList *followList = [[UserUnFollowList alloc] init];
    followList.delegate = self;
    [[NetRequestManager defaultManager] startRequest:followList];
}

- (IBAction)closeBtnDidPressed:(id)sender
{
    [self hideCenterToRightAnimation];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserFirendCellView *friendCellView = [UserFirendCellView loadFromNib];
    return friendCellView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
}

@end
