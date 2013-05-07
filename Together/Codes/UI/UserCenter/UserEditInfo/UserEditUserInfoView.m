//
//  UserEditUserICenterView.m
//  Together
//
//  Created by APPLE on 13-4-28.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserEditUserInfoView.h"
#import "UserEditUserInfoCellView.h"

@implementation UserEditUserInfoView

- (void)awakeFromNib
{
    _iTableView.delegate = self;
    _iTableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
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
            cell.iRightLb.text = @"男";
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



- (IBAction)backBtnDidPressed:(id)sender
{
    [self hideCenterToRightAnimation];
}
@end
