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
#import "RecorderView.h"
@implementation UserEditUserInfoView

@synthesize delegate = _delegate;
@synthesize panGesture;
@synthesize recorderId = _recorderId;
@synthesize avartaId = _avartaId;

- (void)RecorderView:(RecorderView *)v
   recordId:(NSString *)recordId
{
    self.recorderId = recordId;
}

- (void)RecorderViewBeginRecord:(RecorderView *)v
{
    panGesture.enabled = NO;
    [_iRecordLb setText:@"松开提交"];
    _iRecordLb.textColor = [UIColor redColor];
}

- (void)RecorderViewEndRecord:(RecorderView *)v
{
    panGesture.enabled = YES;
    [_iRecordLb setText:@"按下录音"];
    _iRecordLb.textColor = [UIColor blackColor];
}

- (void)viewDidLoad
{
    RecorderView *recordView = [RecorderView loadFromNib];
    recordView.recordFrame = CGRectMake(8, 499, 306, 44);
    recordView.delegate = self;
    [self.view addSubview:recordView];
    
    _iTableView.delegate = self;
    _iTableView.dataSource = self;
    [_iAvartImg setImageWithFileID:[GEMTUserManager defaultManager].userInfo.avataId placeholderImage:[UIImage imageNamed:@"user_default_avatar.png"]];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
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
            cell.iRightLb.text = [GEMTUserManager defaultManager].userInfo.eGenderType ? @"男":@"女";
            break;
        }
        case 2:
        {
            cell.iLeftLb.text = @"出生年月";
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
        _avarta.eType = cutType_avatar;
        
           }
    [_avarta addAvataActionSheet];
}

- (void)AsyncSocketUploadSuccess:(AsyncSocketUpload*)uploadObject
{
    self.avartaId = uploadObject.fileID;
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
    _iAvartImg.image = uploadObject.image;
}

- (void)AsyncSocketUploadFail:(AsyncSocketUpload*)uploadObject
{
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
    NSLog(@"fail");
}

- (void)PicChangeSuccess:(PicChange *)v img:(UIImage *)img
{
    if (img)
    {
        [[TipViewManager defaultManager] showTipText:@"loading"
                                           imageName:@""
                                              inView:self.view
                                                  ID:self];
        _upload = [[AsyncSocketUpload alloc] init];
        _upload.image = img;
        _upload.userID = [GEMTUserManager defaultManager].userInfo.userId;
        _upload.delegate = self;
        _upload.sid = [GEMTUserManager defaultManager].sId;
        [_upload starRequest];
    }

}


- (NSString*) _getCellRightValueWithIndex:(int)i
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
    UserEditUserInfoCellView *cell = (UserEditUserInfoCellView*)[_iTableView cellForRowAtIndexPath:indexPath];
    return cell.iRightLb.text;
}

- (IBAction)submitBtnDidPressed:(id)sender
{
    
    NSString *nickName = [self _getCellRightValueWithIndex:0];
    NSString *sexName = [self _getCellRightValueWithIndex:1];
    NSString *birthDay = [self _getCellRightValueWithIndex:2];
    NSString *signName = [self _getCellRightValueWithIndex:3];
    
    UserInfoModifyRequest *modifyRequest = [[UserInfoModifyRequest alloc] init];
    modifyRequest.nickName = nickName;
    modifyRequest.sex = [sexName isEqualToString:@"女"]?@"0":@"1";
    modifyRequest.sign = signName;
    
    if (_avartaId)
    {
        modifyRequest.avatarId = _avartaId;
    }else
    {
        modifyRequest.avatarId = [GEMTUserManager defaultManager].userInfo.avataId;
    }
    if (_recorderId) {
        modifyRequest.recordId = _recorderId;
    }else
    {
        modifyRequest.recordId = [GEMTUserManager defaultManager].userInfo.signatureRecordId;
    }
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
    [[TipViewManager defaultManager] hideTipWithID:self animation:YES];
    NSString *nickName = [self _getCellRightValueWithIndex:0];
    NSString *sexName = [self _getCellRightValueWithIndex:1];
    NSString *birthDay = [self _getCellRightValueWithIndex:2];
    NSString *signName = [self _getCellRightValueWithIndex:3];
    
    [GEMTUserManager defaultManager].userInfo.nickName = nickName;
    [GEMTUserManager defaultManager].userInfo.eGenderType = [sexName isEqualToString:@"女"]?0:1;
    [GEMTUserManager defaultManager].userInfo.signatureText = signName;
    [[GEMTUserManager defaultManager].userInfo setAge:birthDay];
    [GEMTUserManager defaultManager].userInfo.birthday = birthDay;
    if (_avartaId) {
        [GEMTUserManager defaultManager].userInfo.avataId = _avartaId;
    }
    if (_recorderId) {
        [GEMTUserManager defaultManager].userInfo.signatureRecordId = _recorderId;
    }
    [[GEMTUserManager defaultManager] userInfoWirteToFile];
    
    [_delegate UserEditDidSuccess:self userInfo:[GEMTUserManager defaultManager].userInfo];
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
    _iRecordLb = nil;
    _iAvartImg = nil;
    [super viewDidUnload];
}
@end
