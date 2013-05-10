//
//  RoomGridView.m
//  Together
//
//  Created by Gnef_jp on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "CommonTool.h"
#import "AppSetting.h"
#import "TipViewManager.h"

#import "RoomCell.h"
#import "RoomGridView.h"

#import "RoomViewController.h"

#import "RoomGetListRequest.h"
#import "GridBottomView.h"

#import "SearchPicker.h"

#define kTopRefreshHeight       10
#define kLoadMoreHeight         50

@implementation RoomGridView

- (void) dealloc
{
    [[TipViewManager defaultManager] removeTipWithID:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void) awakeFromNib
{
    _roomTypes = [NSArray arrayWithObjects:@"全部", @"桌游", @"餐饮", @"运动", @"购物", @"电影", nil];
    _ranges = [NSArray arrayWithObjects:@"全部", @"100m 之内", @"300m 之内", @"500m 之内",
                                        @"1km 之内",  @"3km 之内",  @"5km 之内", nil];
    
    _roomList = [[NetRoomList alloc] init];
    [self _setRange:0];
    [self _setRoomType:RoomType_All];
    
    _refreshView = [[SRRefreshView alloc] init];
    _refreshView.delegate = self;
    _refreshView.upInset = kTopRefreshHeight;
    [_roomsTableView addSubview:_refreshView];
    
    _bottomView = [GridBottomView loadFromNib];
    _bottomView.loadingColor = GMETColorRGBMake(252, 85, 31);
    _bottomView.state = _roomList.isFinish ? GridBottomViewState_Finish : GridBottomViewState_LoadMore;
    _bottomView.hidden = YES;
    _bottomView.center = CGPointMake(self.boundsWidth / 2.0,
                                     _roomsTableView.boundsHeight + _bottomView.boundsHeight);
    [_roomsTableView addSubview:_bottomView];
    
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


- (IBAction)roomTypeSelected:(id)sender
{
    SearchPicker *picker = [SearchPicker showPickerWithData:_roomTypes
                                                           origin:CGPointMake(0, 104)
                                                         delegate:self];
    picker.type = SearchPickerType_RoomType;
}


- (void) _setRoomType:(RoomType)roomType
{
    _roomType = roomType;
    [_roomTypeBtn setTitle:[_roomTypes objectAtIndex:roomType] forState:UIControlStateNormal];
    [_roomTypeBtn setTitle:[_roomTypes objectAtIndex:roomType] forState:UIControlStateHighlighted];
}


- (IBAction)distanceSelected:(id)sender
{
    SearchPicker *picker = [SearchPicker showPickerWithData:_ranges
                                                     origin:CGPointMake(160, 104)
                                                   delegate:self];
    picker.type = SearchPickerType_Distance;
}


- (void) _setRange:(int)rangeIndex
{
    CGFloat ranges[] = {
        999999,
        0.1, 0.3, 0.5,
        1.0, 3.0, 5.0,
    };
    
    _range = ranges[rangeIndex];
    [_rangeBtn setTitle:[_ranges objectAtIndex:rangeIndex] forState:UIControlStateNormal];
    [_rangeBtn setTitle:[_ranges objectAtIndex:rangeIndex] forState:UIControlStateHighlighted];
}


#pragma mark- SearchPickerDelegate
- (void) SearchPicker:(SearchPicker *)searchPicker changeValue:(int)value
{
    if (searchPicker.type == SearchPickerType_RoomType)
    {
        [self _setRoomType:value];
    }
    else
    {
        [self _setRange:value];
    }
    
    [self refreshGrid];
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
        getListRequest.delegate = self;
        
        getListRequest.roomType = _roomType;
        getListRequest.range = _range;
        
        getListRequest.pageSize = 10;
        getListRequest.pageNum = page;
        
        getListRequest.location = [AppSetting defaultSetting].currentLocation.coordinate;
        
        [[NetRequestManager defaultManager] startRequest:getListRequest];
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
    
    [_refreshView endRefresh];
    _bottomView.state = _roomList.list.count == 0 ? GridBottomViewState_Finish :
                                                    GridBottomViewState_LoadMore;
    _bottomView.hidden = YES;
}


- (void) NetRoomRequestSuccess:(NetRoomRequest *)request
{
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
    
    if (request.requestType == NetRoomRequestType_GetRooms)
    {
        RoomGetListRequest *getListRequest = (RoomGetListRequest *)request;
        
        [_roomList addItemList:request.responseData onPage:getListRequest.pageNum];
        [_roomsTableView reloadData];
        
        [_refreshView endRefresh];
        _bottomView.state = _roomList.isFinish ? GridBottomViewState_Finish : GridBottomViewState_LoadMore;
        _bottomView.hidden = YES;
    }
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
    return _roomList.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"RoomCellIndentifier";
    
    RoomCell *cell = (RoomCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [RoomCell loadFromNib];
    }
    
    cell.roomItem = (NetRoomItem *)[_roomList itemAtIndex:indexPath.row];
    [cell.previewImageView setImageWithFileID:cell.roomItem.perviewID
                             placeholderImage:[UIImage imageNamed:kDefaultRoomPreview]];
    
    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0)
    {
        [_refreshView scrollViewDidScroll];
    }
    
    if (_bottomView.state == GridBottomViewState_LoadMore &&
        scrollView.contentSize.height  + kLoadMoreHeight <=
        scrollView.contentOffset.y + _roomsTableView.boundsHeight)
    {
        _bottomView.state = GridBottomViewState_Loading;
        _bottomView.hidden = NO;
        _bottomView.center = CGPointMake(self.boundsWidth * 0.5, scrollView.contentSize.height + kLoadMoreHeight);
        
        _roomsTableView.contentSize = CGSizeMake(_roomsTableView.contentSize.width,
                                                   _roomsTableView.contentSize.height + kLoadMoreHeight
                                                   + _bottomView.boundsHeight * 0.5);
        [self _getRoomListOnPage:_roomList.nextPageIndex];
    }
}


- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_refreshView scrollViewDidEndDraging];
}


#pragma mark- SRRefreshViewDelegate
- (void) slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self _getRoomListOnPage:0];
}


@end





