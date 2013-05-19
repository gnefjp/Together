//
//  ChatCell.h
//  Together
//
//  Created by Gnef_jp on 13-5-19.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NetMessageItem;
@interface ChatCell : UITableViewCell
{
    __weak IBOutlet UIView *_targetView;
    __weak IBOutlet UIView *_myView;
}

@property (strong, nonatomic) NetMessageItem    *messageItem;
@property (weak, nonatomic) IBOutlet UILabel    *sendTimeLabel;

@end
