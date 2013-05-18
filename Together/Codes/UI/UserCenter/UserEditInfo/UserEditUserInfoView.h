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
#import "RecorderView.h"
#import "AsyncSocketUpload.h"

@class UserEditUserInfoView;

@protocol UserEditUserInfoViewDelegate <NSObject>

- (void) UserEditDidSuccess:(UserEditUserInfoView*)v;

@end

@interface UserEditUserInfoView : UIViewController<UITableViewDelegate,UITableViewDataSource,InfoFillInViewControllerDelegate,PicChangeDelegate,DataPickerDelegate,NetUserRequestDelegate,RecorderViewDelegate,AsyncSocketUploadDelegate>
{
    __weak IBOutlet UITableView                 *_iTableView;
    DataPicker                                  *_piker;
    PicChange                                   *_avarta;
    
    __weak IBOutlet UIButton                    *_avartaBtn;
    __weak IBOutlet UIButton                    *_recordBtn;
    __weak id<UserEditUserInfoViewDelegate>     _delegate;
    
    __weak IBOutlet UILabel                     *_iRecordLb;
    AsyncSocketUpload                           *_upload;
    NSString                                    *_recorderId;
    NSString                                    *_avartaId;
}

@property (strong, nonatomic)  UIPanGestureRecognizer            *panGesture;
@property (weak) id<UserEditUserInfoViewDelegate>                delegate;
@property (strong, nonatomic)   NSString                       *recorderId;
@property (strong, nonatomic)   NSString                       *avartaId;

- (IBAction)submitBtnDidPressed:(id)sender;
- (IBAction)backBtnDidPressed:(id)sender;

@end
