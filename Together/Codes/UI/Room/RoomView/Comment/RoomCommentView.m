//
//  RoomCommentView.m
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomCommentView.h"
#import "RoomCommentCell.h"
#import "TipViewManager.h"

@implementation RoomCommentView


- (void) dealloc
{
    [[TipViewManager defaultManager] removeTipWithID:self];
}


- (void) awakeFromNib
{
    
}


- (void) setRoomID:(NSString *)roomID
{
    _roomID = roomID;
    
    [self loadNextPage];
}


- (void) loadNextPage
{
    [_commentTableView reloadData];
    
    [self performBlock:^{
        [self.delegate RoomCommentView:self contentSizeChange:_commentTableView.contentSize];
        _commentTableView.frameHeight = _commentTableView.contentSize.height;
        self.frameHeight = _commentTableView.frameHeight;
    }afterDelay:0.75];
}


#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"RoomCommentIdentifier";
    
    RoomCommentCell *cell = (RoomCommentCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [RoomCommentCell loadFromNib];
    }
    
    return cell;
}




@end
