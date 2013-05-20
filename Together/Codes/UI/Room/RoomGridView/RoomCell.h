//
//  RoomCell.h
//  Together
//
//  Created by Gnef_jp on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

@class NetRoomItem;
@interface RoomCell : UITableViewCell

@property (strong,nonatomic) NetRoomItem            *roomItem;
@property (weak, nonatomic) IBOutlet UILabel        *roomTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *previewImageView;
@property (weak, nonatomic) IBOutlet UIImageView    *genderTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel        *beginTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel        *addrTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel        *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel        *joinPersonNum;

@property (weak, nonatomic) IBOutlet UILabel        *ownNicknameLabel;

@property (assign, nonatomic) BOOL                  isNoDistance;
@property (weak, nonatomic) IBOutlet UIImageView *roomTypeImageView;

@end
