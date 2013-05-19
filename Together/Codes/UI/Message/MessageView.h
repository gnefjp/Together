//
//  MessageView.h
//  Together
//
//  Created by Gnef_jp on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "MessageGetListRequest.h"

@class MessageView;
@protocol MessageViewDelegate <NSObject>
- (void) MessageViewWantShowMenu:(MessageView *)messageView;
@end


@class NetMessageList;
@interface MessageView : UIView <NetMessageRequestDelegate>
{
    __weak id <MessageViewDelegate>     _delegate;
    
    NetMessageList                      *_messageList;
}

@property (weak,   nonatomic) id                    delegate;
@property (weak, nonatomic) IBOutlet UITableView    *messageTableView;

- (IBAction)menuDidPressed:(id)sender;

@end
