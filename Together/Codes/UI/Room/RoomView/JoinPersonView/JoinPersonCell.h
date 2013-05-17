//
//  JoinPersonCell.h
//  Together
//
//  Created by Gnef_jp on 13-5-16.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NetUserItem;
@interface JoinPersonCell : UITableViewCell

@property (strong, nonatomic) NetUserItem           *userItem;

@property (weak, nonatomic) IBOutlet UIImageView    *avatarImageView;
@property (weak, nonatomic) IBOutlet UIButton       *relationBtn;
@property (weak, nonatomic) IBOutlet UILabel        *nicknameLabel;

- (IBAction)followDidPressed:(id)sender;

@end
