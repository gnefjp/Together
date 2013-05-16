//
//  RoomViewController.h
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "NetRoomRequest.h"
#import "NetRoomList.h"

@interface RoomViewController : UIViewController <NetRoomRequestDelegate>

@property (strong, nonatomic) NetRoomItem           *roomItem;

@property (weak, nonatomic) IBOutlet UILabel        *roomTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *roomPreviewImageView;
@property (weak, nonatomic) IBOutlet UILabel        *detailAddLabel;
@property (weak, nonatomic) IBOutlet UILabel        *beginTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel        *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel        *nicknameLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *owerAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *joinPersonNumLabel;

- (IBAction)closeBtnPressed:(id)sender;

- (IBAction)joinBtnDidPressed:(id)sender;
- (IBAction)quitBtnDidPressed:(id)sender;
- (IBAction)startBtnDidPressed:(id)sender;

- (IBAction)playRoomSound:(id)sender;

- (IBAction)chatDidPressed:(id)sender;

@end
