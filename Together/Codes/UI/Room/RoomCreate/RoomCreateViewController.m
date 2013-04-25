//
//  RoomCreateViewController.m
//  Together
//
//  Created by Gnef_jp on 13-4-25.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomData.pb.h"
#import "RoomInfoCell.h"

#import "RoomCreateViewController.h"
#import "RoomViewController.h"

#define kRecord_BtnTag      1000

static NSString* s_titles[] = {
    @"主题",
    @"人数限制",
    @"开始时间",
    @"性别限制",
    @"地址",
    @"地址备注",
};


@implementation RoomCreateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _infoTableView.delegate = self;
    _infoTableView.dataSource = self;
}


- (void)viewDidUnload
{
    _infoTableView = nil;
    _recordView = nil;
    _createButton = nil;
    _confirmView = nil;
    [super viewDidUnload];
}


- (IBAction)closeBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)createBtnPressed:(id)sender
{
    [self _isShowRecordView:YES];
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
    RoomViewController* roomViewController = [RoomViewController loadFromNib];
    [self.navigationController pushViewController:roomViewController animated:YES];
}


#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}


- (NSString *) _limitPersonCount
{
    if (_roomInfo.limitPersonCount < 1)
    {
        return @"不限";
    }
    else
    {
        return [NSString stringWithFormat:@"1-%d人", _roomInfo.limitPersonCount];
    }
}


- (NSString *) _beginTime
{
    return @"服务器写少了这个字段";
}


- (NSString *) _genderType
{
    if (_roomInfo.genderType == UserGenderType_Boy)
    {
        return @"男";
    }
    else if (_roomInfo.genderType == UserGenderType_Girl)
    {
        return @"女";
    }

    return @"不限";
}


- (NSString *) _roomInfoAtIndex:(NSInteger)index
{
    NSString* roomInfoStr = nil;
    switch (index)
    {
        case 0:
        {
            roomInfoStr = _roomInfo.title;
            break;
        }
        case 1:
        {
            roomInfoStr = [self _limitPersonCount];
            break;
        }
        case 2:
        {
            roomInfoStr = [self _beginTime];
            break;
        }
        case 3:
        {
            roomInfoStr = [self _genderType];
            break;
        }
        case 4:
        {
            roomInfoStr = _roomInfo.address;
            break;
        }
        case 5:
        {
            roomInfoStr = @"服务器写少了这个字段";
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
