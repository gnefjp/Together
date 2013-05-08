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
#import "UserInfoModifyRequest.h"

@interface UserEditUserInfoView : UIViewController<UITableViewDelegate,UITableViewDataSource,InfoFillInViewControllerDelegate,PicChangeDelegate,DataPickerDelegate,NetUserRequestDelegate>
{
    __weak IBOutlet UITableView *_iTableView;
    DataPicker                  *_piker;
    PicChange                   *_avarta;
    
    __weak IBOutlet UIButton    *_avartaBtn;
    __weak IBOutlet UIButton    *_recordBtn;
    
}

- (IBAction)submitBtnDidPressed:(id)sender;
- (IBAction)backBtnDidPressed:(id)sender;

@end
