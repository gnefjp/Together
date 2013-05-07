//
//  RoomGridView.m
//  Together
//
//  Created by Gnef_jp on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "AppSetting.h"
#import "TipViewManager.h"

#import "RoomCell.h"
#import "RoomGridView.h"

#import "RoomViewController.h"

#import "RoomGetListRequest.h"

@implementation RoomGridView


- (void) dealloc
{
    [[TipViewManager defaultManager] removeTipWithID:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void) awakeFromNib
{
    _noLocationLabel.text = @"无法查看房间信息\n\n"
                            "请到 设置 - 隐私 - 定位服务 中 \n"
                            "打开定位服务功能\n"
                            "并允许“Together”访问此功能\n\n\n\n";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshGrid)
                                                 name:kNotification_InitCurrentLocation
                                               object:nil];
}


- (void) refreshGrid
{
    [[TipViewManager defaultManager] showTipText:nil imageName:nil inView:self ID:self];
    [self _getRoomListOnPage:0];
}


#pragma mark- request
- (void) _getRoomListOnPage:(NSInteger)page
{
    if ([AppSetting defaultSetting].currentLocation == nil)
    {
        self.userInteractionEnabled = NO;
        _noLocationLabel.hidden = NO;
        [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
    }
    else
    {
        self.userInteractionEnabled = YES;
        _noLocationLabel.hidden = YES;
        
        RoomGetListRequest* getListRequest = [[RoomGetListRequest alloc] init];
        //    getListRequest.userID = [AppSetting defaultSetting]
        
        getListRequest.roomType = _roomType;
        getListRequest.range = _range;
        
        getListRequest.pageSize = 10;
        getListRequest.pageNum = page;
        
        getListRequest.location = [AppSetting defaultSetting].currentLocation.coordinate;
        
//        [[NetRequestManager defaultManager] startRequest:getListRequest];
    }
}


#pragma mark- NetRoomRequestDelegate
- (void) NetRoomRequestFail:(NetRoomRequest *)request
{
    [[TipViewManager defaultManager] showTipText:@"获取列表失败"
                                       imageName:kCommonImage_FailIcon
                                          inView:self
                                              ID:self];
    
    [[TipViewManager defaultManager] hideTipWithID:self
                                         animation:YES
                                             delay:1.25];
}


- (void) NetRoomRequestSuccess:(NetRoomRequest *)request
{
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
}


#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RoomViewController *roomViewController = [RoomViewController loadFromNib];
    [[UIView rootController] pushViewController:roomViewController animated:YES];
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"RoomCellIndentifier";
    
    RoomCell *cell = (RoomCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [RoomCell loadFromNib];
    }
    
    return cell;
}



@end





