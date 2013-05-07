//
//  UserEditUserICenterView.h
//  Together
//
//  Created by APPLE on 13-4-28.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoFillInViewController.h"
#import "DataPicker.h"
#import "PicChange.h"

@interface UserEditUserInfoView : UIViewController<UITableViewDelegate,UITableViewDataSource,InfoFillInViewControllerDelegate,PicChangeDelegate>
{
    __weak IBOutlet UITableView *_iTableView;
    DataPicker                  *_piker;
    PicChange                   *_avarta;
    
    __weak IBOutlet UIButton    *_avartaBtn;
}

- (IBAction)submitBtnDidPressed:(id)sender;
- (IBAction)backBtnDidPressed:(id)sender;

@end
