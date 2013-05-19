//
//  RoomCommentView.h
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetMessageRequest.h"

@class RoomCommentView;
@protocol RoomCommentViewDelegate <NSObject>
- (void) RoomCommentView:(RoomCommentView *)roomCommentView contentSizeChange:(CGSize)contentSize;
@end


@class NetRoomItem;
@class NetMessageList;
@interface RoomCommentView : UIView <NetMessageRequestDelegate>
{
    BOOL    _isLoading;
}

@property (strong, nonatomic) NetMessageList                    *commentList;
@property (strong, nonatomic) NetRoomItem                       *roomItem;
@property (weak,   nonatomic) IBOutlet UITableView              *commentTableView;
@property (weak,   nonatomic) id <RoomCommentViewDelegate>      delegate;

- (void) getCommentsWithDirect:(GetListDirect)getListDirect;
- (void) loadNextPage;
- (void) insertItemAtFirstAnimation;

@end
