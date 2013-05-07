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

@implementation UserEditUserInfoView

- (void)awakeFromNib
{
    
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
            [self _showInfoFillViewWithType:InfoFillType_TextView title:@"昵称"];
            break;
        }
        case 1:
        {
            InfoFillInViewController *fillController = [self _showInfoFillViewWithType:InfoFillType_Picker title:@"性别"];
            fillController.dataList = [NSArray arrayWithObjects:@"男", @"女", nil];
            break;
        }
       
        case 2:
        {
            if (!_piker) {
                _piker = [[DataPicker alloc] init];
            }
            [_piker showViewPickerInView:self.view];
            
            break;
        }
        case 3:
        {
            [self _showInfoFillViewWithType:InfoFillType_TextField
                                       title:@"个性签名"];
        }			
            break;
        default:
            break;
    }
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
            cell.iRightLb.text = @"哈哈哈";
            break;
        }
        case 1:
        {
            cell.iLeftLb.text = @"性别";
            cell.iRightLb.text = @"男";
            break;
        }
        case 2:
        {
            cell.iLeftLb.text = @"生日";
            cell.iRightLb.text = @"xx-ss-ss-s-s-s-s";
            break;
        }
        case 3:
        {
            cell.iLeftLb.text = @"个性签名";
            cell.iRightLb.text = @"你这个死suohi";
            break;
        }
        default:
            break;
    }
    return cell;
}

- (void) InfoFillInViewController:(InfoFillInViewController *)controller fillValue:(NSString *)fillValue
{
    
}

- (InfoFillInViewController*) _showInfoFillViewWithType:(InfoFillType)type
                                                  title:(NSString *)title
{   
    InfoFillInViewController* fillController = [InfoFillInViewController loadFromNib];
    fillController.delegate = self;
    [[UIView rootController] pushViewController:fillController animated:YES];
    fillController.fillType = type;
    fillController.titleLabel.text = title;
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

- (IBAction)submitBtnDidPressed:(id)sender
{
    
}

- (IBAction)backBtnDidPressed:(id)sender
{
    [[UIView rootController] popViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    _iTableView = nil;
    _avartaBtn = nil;
    [super viewDidUnload];
}
@end
