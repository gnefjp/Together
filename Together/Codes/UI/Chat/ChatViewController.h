//
//  ChatViewController.h
//  Together
//
//  Created by Gnef_jp on 13-5-19.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NetMessageList;
@class ChatInputView;
@interface ChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    ChatInputView                   *_chatInputView;
    __weak IBOutlet UITableView     *_chatTableView;
    
    NetMessageList                  *_chatList;
}

@property (copy, nonatomic) NSString            *userID;
@property (copy, nonatomic) NSString            *nickname;
@property (weak, nonatomic) IBOutlet UILabel    *targetNicknameLabel;


@end
