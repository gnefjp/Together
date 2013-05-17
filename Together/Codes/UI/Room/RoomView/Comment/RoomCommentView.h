//
//  RoomCommentView.h
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomCommentView;
@protocol RoomCommentViewDelegate <NSObject>
- (void) RoomCommentView:(RoomCommentView *)roomCommentView contentSizeChange:(CGSize)contentSize;
@end


@interface RoomCommentView : UIView
{
    
}

@property (strong, nonatomic) NSString                          *roomID;
@property (weak,   nonatomic) IBOutlet UITableView              *commentTableView;
@property (weak,   nonatomic) id <RoomCommentViewDelegate>      delegate;

- (void) loadNextPage;

@end
