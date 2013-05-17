//
//  JoinPersonViewController.m
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "NetUserList.h"

#import "JoinPersonViewController.h"
#import "JoinPersonCell.h"

@implementation JoinPersonViewController


- (void)viewDidUnload
{
    [self setPersonTableView:nil];
    
    [super viewDidUnload];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _personTableView.dataSource = self;
    _personTableView.delegate = self;
}


- (void) setUserList:(NetUserList *)userList
{
    _userList = userList;
    
    [_personTableView reloadData];
}


- (IBAction)backBtnDidPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: 进入个人中心
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _userList.list.count;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"已经有 %d 个人加入这房间了", _joinPersonNum];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"JoinPersonCellIdentifier";
    
    JoinPersonCell *cell = (JoinPersonCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [JoinPersonCell loadFromNib];
    }
    
    cell.userItem = (NetUserItem *)[_userList itemAtIndex:indexPath.row];
    
    return cell;
}

@end
