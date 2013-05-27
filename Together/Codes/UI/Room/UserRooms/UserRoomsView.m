//
//  UserRoomsView.m
//  Together
//
//  Created by Gnef_jp on 13-5-19.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "CommonTool.h"
#import "TipViewManager.h"
#import "GEMTUserManager.h"

#import "UserRoomsView.h"
#import "SearchPicker.h"

#import "GridBottomView.h"
#import "RoomCell.h"
#import "RoomViewController.h"

#import "RoomGetUserRoomsRequest.h"
#import "RoomShowInfoRequest.h"

@implementation UserRoomsView

#define kBelongs_BtnTag         1000
#define kState_BtnTag           1001

#define kTopRefreshHeight       10
#define kLoadMoreHeight         50

@synthesize delegate = _delegate;

+ (UserRoomsView *) userRoomViewWithUserId:(NSString *)userId
                                  nickname:(NSString *)nickname
                             isShowBackBtn:(BOOL)isShowBackBtn
                                  delegate:(id)delegate
{
    UserRoomsView *userRoomsView = [UserRoomsView loadFromNib];
    userRoomsView.delegate = delegate;
    userRoomsView.isShowBackBtn = isShowBackBtn;
    userRoomsView.userId = userId;
    userRoomsView.nickname = nickname;
    
    return userRoomsView;
}


- (void) dealloc
{
    [[TipViewManager defaultManager] removeTipWithID:self];
}


- (void) awakeFromNib
{
    _roomBelongsTypes = [NSArray arrayWithObjects:@"创建的", @"加入的", nil];
    _roomStates = [NSArray arrayWithObjects:@"等待中", @"已结束", nil];
    
    _roomList = [[NetRoomList alloc] init];
    _isMyRoom = YES;
    _roomState = RoomState_Waiting;
    
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
}


- (void) setIsShowBackBtn:(BOOL)isShowBackBtn
{
    _isShowBackBtn = isShowBackBtn;
    
    _menuBtn.hidden = _isShowBackBtn;
    _backBtn.hidden = !_isShowBackBtn;
}


- (void) setNickname:(NSString *)nickname
{
    _nickname = nickname;
    
    _nicknameLabel.text = _nickname;
}


- (void) setUserId:(NSString *)userId
{
    _userId = userId;
    
    [self refreshGrid];
}


- (IBAction)roomBelongSelected:(id)sender
{
    SearchPicker *picker = [SearchPicker showPickerWithData:_roomBelongsTypes
                                                     origin:CGPointMake(0, 104)
                                                   delegate:self];
    picker.type = SearchPickerType_Belongs;
}


- (IBAction)roomStateSelected:(id)sender
{
    SearchPicker *picker = [SearchPicker showPickerWithData:_roomStates
                                                     origin:CGPointMake(160, 104)
                                                   delegate:self];
    picker.type = SearchPickerType_State;
}


- (IBAction)menuDidPressed:(id)sender
{
    if ([_delegate respondsToSelector:@selector(UserRoomsViewWantShowNavigation:)])
    {
        [_delegate UserRoomsViewWantShowNavigation:self];
    }
}


- (IBAction)backDidPressed:(id)sender
{
    if ([_delegate respondsToSelector:@selector(UserRoomsViewWantBack:)])
    {
        [_delegate UserRoomsViewWantBack:self];
    }
}


#pragma mark- request
- (void) refreshGrid
{
    [[TipViewManager defaultManager] showTipText:nil imageName:nil inView:self ID:self];
    [self _getRoomsOnPage:0];
}


- (void) _getRoomsOnPage:(NSInteger)page
{
    RoomGetUserRoomsRequest *getListRequest = [[RoomGetUserRoomsRequest alloc] init];
    getListRequest.delegate = self;
    
    getListRequest.sid = [GEMTUserManager defaultManager].sId;
    getListRequest.isMyRoom = _isMyRoom;
    getListRequest.roomStatus = _roomState;
    
    getListRequest.pageSize = 10;
    getListRequest.pageNum = page;
    
    [[NetRequestManager defaultManager] startRequest:getListRequest];
}


#pragma mark- NetRoomRequestDelegate
- (void) NetRoomRequestFail:(NetRoomRequest *)request
{
    if (request.requestType == NetRoomRequestType_GetUserRooms)
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
    else if (request.requestType == NetRoomRequestType_ShowRoomInfo)
    {
        [[TipViewManager defaultManager] showTipText:@"获取房间信息失败"
                                           imageName:kCommonImage_FailIcon
                                              inView:self
                                                  ID:self];
        
        [[TipViewManager defaultManager] hideTipWithID:self
                                             animation:YES
                                                 delay:1.25];
    }
}


- (void) NetRoomRequestSuccess:(NetRoomRequest *)request
{
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
    
    if (request.requestType == NetRoomRequestType_GetUserRooms)
    {
        RoomGetUserRoomsRequest *getListRequest = (RoomGetUserRoomsRequest *)request;
        
        [_roomList addItemList:request.responseData onPage:getListRequest.pageNum];
        [_roomsTableView reloadData];
        
        [_refreshView endRefresh];
        _bottomView.state = _roomList.isFinish ? GridBottomViewState_Finish : GridBottomViewState_LoadMore;
        _bottomView.hidden = YES;
    }
    else if (request.requestType == NetRoomRequestType_ShowRoomInfo)
    {
        RoomViewController *roomViewController = [RoomViewController loadFromNib];
        [[UIView rootController] pushViewController:roomViewController animated:YES];
        roomViewController.roomItem = (NetRoomItem *) [NetRoomItem itemWithMessage:
                                                       request.responseData.roomInfoResponse.roomInfo];
    }
}


#pragma mark- SearchPickerDelegate
- (void) SearchPicker:(SearchPicker *)searchPicker changeValue:(int)value
{
    if (searchPicker.type == SearchPickerType_Belongs)
    {
        UIButton *belongBtn = [self viewWithTag:kBelongs_BtnTag recursive:NO];
        [belongBtn setTitle:[_roomBelongsTypes objectAtIndex:value] forState:UIControlStateNormal];
        [belongBtn setTitle:[_roomBelongsTypes objectAtIndex:value] forState:UIControlStateHighlighted];
        
        _isMyRoom = (value == 0);
    }
    else if (searchPicker.type == SearchPickerType_State)
    {
        UIButton *stateBtn = [self viewWithTag:kState_BtnTag recursive:NO];
        [stateBtn setTitle:[_roomStates objectAtIndex:value] forState:UIControlStateNormal];
        [stateBtn setTitle:[_roomStates objectAtIndex:value] forState:UIControlStateHighlighted];
        
        _roomState = (value == 0) ? RoomState_Waiting : RoomState_Ended;
    }
    
    [self refreshGrid];
}



#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![[GEMTUserManager defaultManager] shouldAddLoginViewToTopView])
    {
        NetRoomItem *roomItem = (NetRoomItem *)[_roomList itemAtIndex:indexPath.row];
        //        if (roomItem.genderLimitType == UserGenderType_Boy && [GEMTUserManager defaultManager].userInfo.sex)
        
        
        [[TipViewManager defaultManager] showTipText:nil imageName:nil inView:self ID:self];
        
        RoomShowInfoRequest *showRequest = [[RoomShowInfoRequest alloc] init];
        showRequest.delegate = self;
        
        showRequest.roomID = roomItem.ID;
        showRequest.userID = [GEMTUserManager defaultManager].userInfo.userId;
        showRequest.sid = [GEMTUserManager defaultManager].sId;
        
        [[NetRequestManager defaultManager] startRequest:showRequest];
    }
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
    
    cell.isNoDistance = YES;
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
        [self _getRoomsOnPage:_roomList.nextPageIndex];
    }
}


- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_refreshView scrollViewDidEndDraging];
}


#pragma mark- SRRefreshViewDelegate
- (void) slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self _getRoomsOnPage:0];
}


@end
