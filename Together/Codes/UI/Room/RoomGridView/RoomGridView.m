//
//  RoomGridView.m
//  Together
//
//  Created by Gnef_jp on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomCell.h"
#import "RoomGridView.h"

#import "RoomViewController.h"

@implementation RoomGridView


- (void) awakeFromNib
{
    
}


#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RoomViewController *roomViewController = [RoomViewController loadFromNib];
    [[UIView rootController] pushViewController:roomViewController animated:YES];
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"RoomCellIndentifier";
    
    RoomCell *cell = (RoomCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [RoomCell loadFromNib];
    }
    
    return cell;
}



@end





