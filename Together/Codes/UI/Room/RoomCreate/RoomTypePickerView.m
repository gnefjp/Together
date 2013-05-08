//
//  RoomTypePickerView.m
//  Together
//
//  Created by Gnef_jp on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomTypePickerView.h"


static NSString* s_roomTypeNames[] = {
    @"其他",
    @"桌游",
    @"餐饮",
    @"运动",
    @"购物",
    @"电影",
};

@implementation RoomTypePickerView
@synthesize delegate = _delegate;


- (IBAction)cancelBtnPressed:(id)sender
{
    if ([_delegate respondsToSelector:@selector(RoomTypePickerViewWantCancel:)])
    {
        [_delegate RoomTypePickerViewWantCancel:self];
    }
}


#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(RoomTypePickerView:pickRoomType:)])
    {
        [_delegate RoomTypePickerView:self pickRoomType:indexPath.row + 1];
    }
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return RoomType_Max;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoFillCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    NSString* showMsg = s_roomTypeNames[indexPath.row];
    cell.textLabel.text = showMsg;
    return cell;
}
@end
