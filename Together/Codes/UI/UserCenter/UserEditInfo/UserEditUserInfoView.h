//
//  UserEditUserICenterView.h
//  Together
//
//  Created by APPLE on 13-4-28.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoFillInViewController.h"
@interface UserEditUserInfoView : UIView<UITableViewDelegate,UITableViewDataSource,InfoFillInViewControllerDelegate>
{
    __weak IBOutlet UITableView *_iTableView;
    
}


- (IBAction)backBtnDidPressed:(id)sender;

@end
