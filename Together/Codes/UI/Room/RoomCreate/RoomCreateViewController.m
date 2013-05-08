//
//  RoomCreateViewController.m
//  Together
//
//  Created by Gnef_jp on 13-4-25.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "GMETTapView.h"
#import "TipViewManager.h"

#import "NetRoomList.h"
#import "RoomInfoCell.h"

#import "RoomTypePickerView.h"

#import "InfoFillInViewController.h"

#import "RoomCreateViewController.h"
#import "RoomViewController.h"

#import "RoomCreateRequest.h"

#define kRecord_BtnTag      1000 // For _recordView
#define kRoomType_BtnTag    1000 // For self.view

static NSString* s_titles[] = {
    @"主题",
    @"人数限制",
    @"开始时间",
    @"性别限制",
    @"地址",
    @"地址备注",
};


static NSString* s_genderTypes[] = {
    @"不限",
    @"只限男",
    @"只限女",
};


static NSString* s_roomTypeNames[] = {
    @"其他",
    @"桌游",
    @"餐饮",
    @"运动",
    @"购物",
    @"电影",
};


@implementation RoomCreateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _infoTableView.delegate = self;
    _infoTableView.dataSource = self;
    
    _roomInfo = [[NetRoomItem alloc] init];
    
    [self _isShowRoomTypePicker:YES animation:NO];
}


- (void) dealloc
{
    [[TipViewManager defaultManager] removeTipWithID:self];
}


- (void)viewDidUnload
{
    _infoTableView = nil;
    _recordView = nil;
    _createButton = nil;
    _confirmView = nil;
    
    [[TipViewManager defaultManager] removeTipWithID:self];
    [super viewDidUnload];
}


- (IBAction)closeBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)roomTypeBtnPressed:(id)sender
{
    [self _isShowRoomTypePicker:YES animation:YES];
}


- (IBAction)createBtnPressed:(id)sender
{
    [self _isShowRecordView:YES];
}


#pragma mark- 类型选择
- (void) _isShowRoomTypePicker:(BOOL)isShow animation:(BOOL)animation
{
    if (isShow)
    {
        [_roomTypePickerView removeFromSuperview];
        _roomTypePickerView = [RoomTypePickerView loadFromNib];
        _roomTypePickerView.delegate = self;
        [self.view addSubview:_roomTypePickerView];
    }
    
    if (!animation)
    {
        _roomTypePickerView.frameY = isShow ? 0.0 : self.view.boundsHeight;
        if (!isShow)
        {
            [_roomTypePickerView removeFromSuperview];
            _roomTypePickerView = nil;
        }
        return;
    }
    
    _roomTypePickerView.frameY = isShow ? self.view.boundsHeight : 0.0;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                         _roomTypePickerView.frameY = isShow ? 0.0 : self.view.boundsHeight;
                         
                     }completion:^(BOOL finished){
                        
                         if (!isShow)
                         {
                             [_roomTypePickerView removeFromSuperview];
                             _roomTypePickerView = nil;
                         }
                         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         
                     }];
}


#pragma mark- RoomTypePickerViewDelegate
- (void) RoomTypePickerViewWantCancel:(RoomTypePickerView *)roomTypePickerView
{
    if (_hasPickRoomType)
    {
        [self _isShowRoomTypePicker:NO animation:YES];
    }
    else
    {
        [self closeBtnPressed:nil];
    }
}


- (void) RoomTypePickerView:(RoomTypePickerView *)pickerView pickRoomType:(RoomType)roomType
{
    _hasPickRoomType = YES;
    _roomInfo.roomType = roomType;
    
    UIButton* roomTypeBtn = [self.view viewWithTag:kRoomType_BtnTag
                                         recursive:NO];
    
    [roomTypeBtn setTitle:s_roomTypeNames[_roomInfo.roomType]
                 forState:UIControlStateNormal];
    [roomTypeBtn setTitle:s_roomTypeNames[_roomInfo.roomType]
                 forState:UIControlStateHighlighted];
    
    [self _isShowRoomTypePicker:NO animation:YES];
}


#pragma mark- 录音
- (IBAction)startRecord:(id)sender
{
    // TODO: 开始录音
}


- (IBAction)confirmRecord:(id)sender
{
    // TODO: 确定录音
    [self _isShowConfirmView:YES];
}


- (IBAction)cancelRecord:(id)sender
{
    // TODO: 取消录音
}


- (void) _isShowRecordView:(BOOL)isShow
{
    _createButton.frameX = isShow ? 0.0 : -300.0;
    _recordView.frameX = isShow ? 320.0 : 0.0;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                         _createButton.frameX = isShow ? -300.0 : 20.0;
                         _recordView.frameX = isShow ? 0.0 : 320.0;
                         
                     }completion:^(BOOL finished){
                         
                         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         
                     }];
}


- (IBAction)backToCreateView:(id)sender
{
    [self _isShowRecordView:NO];
}


#pragma mark- 确定
- (void) _isShowConfirmView:(BOOL)isShow
{
    _recordView.frameX = isShow ? 0.0 : -320.0;
    _confirmView.frameX = isShow ? 320.0 : 0.0;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                         _recordView.frameX = isShow ? -320.0 : 0.0;
                         _confirmView.frameX = isShow ? 0.0 : 320.0;
                         
                     }completion:^(BOOL finished){
                         
                         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         
                     }];
}


- (IBAction)backToRecord:(id)sender
{
    [self _isShowConfirmView:NO];
}


- (IBAction)playOrStopRecord:(id)sender
{
    // TODO: 播放录音
}


- (IBAction)confirmToCreate:(id)sender
{
    // TODO: 确定创建
    RoomCreateRequest* createRequest = [[RoomCreateRequest alloc] init];
    createRequest.sid = @"b7fbee9a885057aa638df19ecfccb5ba";
    createRequest.ownerID = @"1";
    createRequest.ownerNickname = @"G-Mart";
    
    createRequest.roomTitle = _roomInfo.roomTitle;
    createRequest.roomType = _roomInfo.roomType;
    
    createRequest.beginTime = _roomInfo.beginTime;
    
    createRequest.personNumLimit = _roomInfo.personLimitNum;
    createRequest.genderType = _roomInfo.genderLimitType;
    
    createRequest.address = _roomInfo.address;
    
    createRequest.previewID = @"2";
    createRequest.recordID = @"1";
    
    [[NetRequestManager defaultManager] startRequest:createRequest];
}


#pragma mark- NetRoomRequestDelegate
- (void) NetRoomRequestFail:(NetRoomRequest *)request
{
    if (request.requestType == NetRoomRequestType_CreateRoom)
    {
        [[TipViewManager defaultManager] showTipText:@"创建房间失败"
                                           imageName:kCommonImage_FailIcon
                                              inView:self.view
                                                  ID:self];
        [[TipViewManager defaultManager] hideTipWithID:self
                                             animation:YES
                                                 delay:1.25];
    }
}


- (void) NetRoomRequestSuccess:(NetRoomRequest *)request
{
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
    
    if (request.requestType == NetRoomRequestType_CreateRoom)
    {
        RoomViewController* roomViewController = [RoomViewController loadFromNib];
        [self.navigationController pushViewController:roomViewController animated:YES];
    }
}


#pragma mark- GMETTapViewDelegate
- (void) GMETTapView:(GMETTapView *)tapView touchEnded:(UIEvent *)event
{
    if (_datePickerView)
    {
        [self _isShow:NO picker:_datePickerView tapView:tapView];
        _datePickerView = nil;
    }
}


#pragma mark- CellSelected
- (GMETTapView *) _tapView
{
    GMETTapView* tapView = [[GMETTapView alloc] initWithFrame:self.view.bounds];
    tapView.delegate = self;
    tapView.backgroundColor = [UIColor blackColor];
    tapView.alpha = 0.0f;
    
    return tapView;
}


- (void) _isShow:(BOOL)isShow
          picker:(UIView *)picker
         tapView:(UIView *)tapView
{
    if (isShow)
    {
        [self.view addSubview:tapView];
        picker.frameY = self.view.boundsHeight;
        [self.view addSubview:picker];
    }
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                         tapView.alpha = isShow ? 0.5 : 0.0;
                         picker.frameY = isShow ? self.view.boundsHeight - picker.boundsHeight
                                                : self.view.boundsHeight;
                         
                     }completion:^(BOOL finished){
                         
                         if (!isShow)
                         {
                             [tapView removeFromSuperview];
                             [picker removeFromSuperview];
                         }
                         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         
                     }];
}


- (void) _beginTimeSelected
{
    [_datePickerView removeFromSuperview];
    _datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.boundsWidth, 216)];
    _datePickerView.datePickerMode = UIDatePickerModeDateAndTime;
    [_datePickerView addTarget:self
                        action:@selector(_beginTimeChange:)
              forControlEvents:UIControlEventValueChanged];
    [_datePickerView setMinimumDate:[NSDate date]];
    
    [self _isShow:YES picker:_datePickerView tapView:[self _tapView]];
    [self _beginTimeChange:_datePickerView];
}


- (void) _beginTimeChange:(UIDatePicker *)picker
{
    NSString* beginTime = [NSString stringWithFormat:@"%.0lf",
                           [picker.date timeIntervalSince1970]];
    
    if (_infoTableView.visibleCells.count > 2)
    {
        RoomInfoCell* cell = [_infoTableView.visibleCells objectAtIndex:2];
        cell.contentLabel.text = [beginTime timestampToDateUsingFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        _roomInfo.beginTime = [beginTime timestampToDateUsingFormat:@"yyyyMMddHHmmss"];
    }
}


#pragma mark- InfoFillInViewControllerDelegate
- (void) InfoFillInViewController:(InfoFillInViewController *)controller fillValue:(NSString *)fillValue
{
    if ([controller.titleLabel.text isEqualToString:@"主题"])
    {
        _roomInfo.roomTitle = fillValue;
    }
    else if ([controller.titleLabel.text isEqualToString:@"人数限制"])
    {
        if ([fillValue isEqualToString:@"不限"])
        {
            fillValue = @"-1";
        }
        
        _roomInfo.personLimitNum = [fillValue intValue];
    }
    else if ([controller.titleLabel.text isEqualToString:@"性别限制"])
    {
        for (int i = 0; i < 3; i++)
        {
            if ([fillValue isEqualToString:s_genderTypes[i]])
            {
                _roomInfo.genderLimitType = i;
                break;
            }
        }
    }
    else if ([controller.titleLabel.text isEqualToString:@"地址备注"])
    {
        _roomInfo.address.addrRemark = fillValue;
    }
    
    [_infoTableView reloadData];
}


- (InfoFillInViewController*) _showInfoFillViewWithType:(InfoFillType)type
                                                  title:(NSString *)title
{
    InfoFillInViewController* fillController = [InfoFillInViewController loadFromNib];
    fillController.delegate = self;
    [self.navigationController pushViewController:fillController animated:YES];
    
    fillController.fillType = type;
    fillController.titleLabel.text = title;
    
    return fillController;
}


#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            [self _showInfoFillViewWithType:InfoFillType_TextField
                                      title:s_titles[0]];
            break;
        }
        case 1:
        {
            InfoFillInViewController* fillController = [self _showInfoFillViewWithType:InfoFillType_Picker
                                                                                 title:s_titles[1]];
            fillController.dataList = [NSArray arrayWithObjects:@"不限", @"5", @"10", @"20", @"50", nil];
            break;
        }
        case 2:
        {
            [self _beginTimeSelected];
            break;
        }
        case 3:
        {
            InfoFillInViewController* fillController = [self _showInfoFillViewWithType:InfoFillType_Picker
                                                                                 title:s_titles[3]];
            fillController.dataList = [NSArray arrayWithObjects:s_genderTypes[0], s_genderTypes[1], s_genderTypes[2], nil];
            break;
        }
        case 4:
        {
            
            break;
        }
        case 5:
        {
            [self _showInfoFillViewWithType:InfoFillType_TextView
                                      title:s_titles[5]];
            break;
        }
        default:
            break;
    }
    
    
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}


- (NSString *) _limitPersonCount
{
    if (_roomInfo.personLimitNum < 1)
    {
        return @"不限";
    }
    else
    {
        return [NSString stringWithFormat:@"1-%d人", _roomInfo.personLimitNum];
    }
}


- (NSString *) _roomInfoAtIndex:(NSInteger)index
{
    NSString* roomInfoStr = nil;
    switch (index)
    {
        case 0:
        {
            roomInfoStr = _roomInfo.roomTitle;
            break;
        }
        case 1:
        {
            roomInfoStr = [self _limitPersonCount];
            break;
        }
        case 2:
        {
            roomInfoStr = _roomInfo.beginTime;
            break;
        }
        case 3:
        {
            roomInfoStr = s_genderTypes[_roomInfo.genderLimitType];
            break;
        }
        case 4:
        {
            roomInfoStr = _roomInfo.address.detailAddr;
            break;
        }
        case 5:
        {
            roomInfoStr = _roomInfo.address.addrRemark;
            break;
        }
        default:
            break;
    }
    
    if ([roomInfoStr length] < 1)
    {
        roomInfoStr = @"未填写";
    }
    
    return roomInfoStr;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"RoomInfoCellIndentifier";
    
    RoomInfoCell *cell = (RoomInfoCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [RoomInfoCell loadFromNib];
    }
    
    cell.titleLabel.text = s_titles[indexPath.row];
    cell.contentLabel.text = [self _roomInfoAtIndex:indexPath.row];
    
    return cell;
}

@end
