//
//  JoinPersonViewController.h
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NetUserList;
@interface JoinPersonViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) int                   joinPersonNum;
@property (strong, nonatomic) NetUserList           *userList;
@property (weak,   nonatomic) IBOutlet UITableView  *personTableView;

- (IBAction)backBtnDidPressed:(id)sender;

@end
