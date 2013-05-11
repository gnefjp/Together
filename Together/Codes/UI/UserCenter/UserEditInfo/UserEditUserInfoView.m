//
//  UserEditUserICenterView.m
//  Together
//
//  Created by APPLE on 13-4-28.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserEditUserInfoView.h"
#import "UserEditUserInfoCellView.h"
#import "DataPicker.h"
#import "GEMTUserManager.h"
#import "TipViewManager.h"
@implementation UserEditUserInfoView
@synthesize delegate = _delegate;

- (void)awakeFromNib
{
    _avartaBtn.tag =  [[GEMTUserManager defaultManager].userInfo.avataId intValue];
    _recordBtn.tag =  [[GEMTUserManager defaultManager].userInfo.signatureRecordId intValue];
}

- (void)viewDidLoad
{
    _iTableView.delegate = self;
    _iTableView.dataSource = self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self _showInfoFillViewWithType:InfoFillType_TextField
                                      title:@"昵称"
                                        tag:0];
            break;
        }
        case 1:
        {
            InfoFillInViewController *fillController = [self _showInfoFillViewWithType:InfoFillType_Picker
                                                                                 title:@"性别"
                                                                                   tag:1];
            fillController.dataList = [NSArray arrayWithObjects:@"男", @"女", nil];
            break;
        }
       
        case 2:
        {
            if (!_piker) {
                _piker = [[DataPicker alloc] init];
                _piker.delegate = self;
                
            }
            [_piker showViewPickerInView:self.view
                          withDateString:[GEMTUserManager defaultManager].userInfo.birthday];
            
            break;
        }
        case 3:
        {
            [self _showInfoFillViewWithType:InfoFillType_TextView
                                      title:@"个性签名"
                                        tag:3];
        }
            break;
        default:
            break;
    }
}

- (void)DataPicker:(DataPicker *)d date:(NSDate *)date
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    UserEditUserInfoCellView *cell = (UserEditUserInfoCellView*)[_iTableView cellForRowAtIndexPath:indexPath];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    cell.iRightLb.text = [formatter stringFromDate:date];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserEditUserInfoCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"editUserInfo"];
    if (!cell)
    {
        cell = [UserEditUserInfoCellView loadFromNib];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.iLeftLb.text = @"昵称";
            cell.iRightLb.text = [GEMTUserManager defaultManager]. userInfo.nickName;
            break;
        }
        case 1:
        {
            cell.iLeftLb.text = @"性别";
            cell.iRightLb.text = [GEMTUserManager defaultManager].userInfo.sex ? @"男":@"女";
            break;
        }
        case 2:
        {
//            cell.iLeftLb.text = @"生日";
//            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//            [formatter setDateFormat:@"yyyy-MM-dd"];
            cell.iRightLb.text = [GEMTUserManager defaultManager].userInfo.birthday;
            break;
        }
        case 3:
        {
            cell.iLeftLb.text = @"个性签名";
            cell.iRightLb.text = [GEMTUserManager defaultManager].userInfo.signatureText ;
            break;
        }
        default:
            break;
    }
    return cell;
}

- (void) InfoFillInViewController:(InfoFillInViewController *)controller fillValue:(NSString *)fillValue
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:controller.titleLabel.tag inSection:0];
    UserEditUserInfoCellView *cell = (UserEditUserInfoCellView*)[_iTableView cellForRowAtIndexPath:indexPath];
    cell.iRightLb.text = fillValue;
}

- (InfoFillInViewController*) _showInfoFillViewWithType:(InfoFillType)type
                                                  title:(NSString *)title
                                                    tag:(int)tag
{   
    InfoFillInViewController* fillController = [InfoFillInViewController loadFromNib];
    fillController.delegate = self;
    [[UIView rootController] pushViewController:fillController animated:YES];
    fillController.fillType = type;
    fillController.titleLabel.text = title;
    fillController.titleLabel.tag = tag;
    return fillController;
}

- (IBAction)avataBtnDidPressed:(id)sender
{
    if (!_avarta)
    {
        _avarta = [[PicChange alloc] init];
        _avarta.delegate = self;
    }
    [_avarta addAvataActionSheet];
}

- (void)PicChangeSuccess:(PicChange *)self img:(UIImage *)img
{
    [_avartaBtn setImage:img forState:UIControlStateNormal];
    [_avartaBtn setImage:img forState:UIControlStateHighlighted];

}

- (NSString*) _getCellRightValueWithIndex:(int)i
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
    UserEditUserInfoCellView *cell = (UserEditUserInfoCellView*)[_iTableView cellForRowAtIndexPath:indexPath];
    return cell.iRightLb.text;
}

- (IBAction)submitBtnDidPressed:(id)sender
{
    NSNumber *avatarId = [NSNumber numberWithInt:_avartaBtn.tag];
    NSNumber *recordId = [NSNumber numberWithInt:_recordBtn.tag];
    
    NSString *nickName = [self _getCellRightValueWithIndex:0];
    NSString *sexName = [self _getCellRightValueWithIndex:1];
    NSString *birthDay = [self _getCellRightValueWithIndex:2];
    NSString *signName = [self _getCellRightValueWithIndex:3];
    
    UserInfoModifyRequest *modifyRequest = [[UserInfoModifyRequest alloc] init];
    modifyRequest.nickName = nickName;
    modifyRequest.sex = [NSNumber numberWithInt:[sexName isEqualToString:@"女"]?0:1];
    modifyRequest.sign = signName;
    
    modifyRequest.avatarId = [NSString stringWithFormat:@"%@",avatarId];
    modifyRequest.recordId = [NSString stringWithFormat:@"%@",recordId];
    modifyRequest.birthDay = birthDay;
    modifyRequest.delegate = self;
    
    [[NetRequestManager defaultManager] startRequest:modifyRequest];
    
    [[TipViewManager defaultManager] showTipText:@"loading"
                                       imageName:@""
                                          inView:self.view
                                              ID:self];
    
}


- (void)NetUserRequestSuccess:(NetUserRequest *)request
{
//    NSNumber *avatarId = [NSNumber numberWithInt:_avartaBtn.tag];
//    NSNumber *recordId = [NSNumber numberWithInt:_recordBtn.tag];
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
    NSString *nickName = [self _getCellRightValueWithIndex:0];
    NSString *sexName = [self _getCellRightValueWithIndex:1];
    NSString *birthDay = [self _getCellRightValueWithIndex:2];
    NSString *signName = [self _getCellRightValueWithIndex:3];
    
    [GEMTUserManager defaultManager].userInfo.nickName = nickName;
    [GEMTUserManager defaultManager].userInfo.sex = [NSNumber numberWithInt:[sexName isEqualToString:@"女"]?0:1];
    [GEMTUserManager defaultManager].userInfo.signatureText = signName;
    [[GEMTUserManager defaultManager].userInfo setAge:birthDay];
    [[GEMTUserManager defaultManager] userInfoWirteToFile];
    
    [_delegate UserEditDidSuccess:self];
    [self backBtnDidPressed:nil];
}

- (void)NetUserRequestFail:(NetUserRequest *)request
{
    [[TipViewManager defaultManager] showTipText:@"网络异常,重新请求"
                                       imageName:@""
                                          inView:self.view
                                              ID:self];
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
}

- (IBAction)backBtnDidPressed:(id)sender
{
    [[UIView rootController] popViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    _iTableView = nil;
    _avartaBtn = nil;
    _recordBtn = nil;
    [super viewDidUnload];
}
@end
