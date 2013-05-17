//
//  RoomViewController.h
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "NetRoomRequest.h"
#import "NetRoomList.h"
#import "RoomCommentView.h"

@class ChatInputView;
@class JoinPersonView;
@interface RoomViewController : UIViewController <NetRoomRequestDelegate,
                                                  RoomCommentViewDelegate,
                                                  UIScrollViewDelegate>
{
    JoinPersonView                  *_joinPersonView;
    RoomCommentView                 *_commentView;
    ChatInputView                   *_chatInputView;
    
    __weak IBOutlet UIScrollView    *_mainScrollView;
    __weak IBOutlet UIButton        *_chatBtn;
    __weak IBOutlet UIButton        *_followBtn;
}

@property (strong, nonatomic) NetRoomItem           *roomItem;

@property (weak, nonatomic) IBOutlet UILabel        *roomTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *roomPreviewImageView;
@property (weak, nonatomic) IBOutlet UILabel        *detailAddLabel;
@property (weak, nonatomic) IBOutlet UILabel        *beginTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel        *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel        *nicknameLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *owerAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel        *joinPersonNumLabel;

- (IBAction)closeBtnPressed:(id)sender;

- (IBAction)joinBtnDidPressed:(id)sender;
- (IBAction)quitBtnDidPressed:(id)sender;
- (IBAction)startBtnDidPressed:(id)sender;

- (IBAction)playRoomSound:(id)sender;

- (IBAction)chatDidPressed:(id)sender;
- (IBAction)followOwnDidPressed:(id)sender;

@end
