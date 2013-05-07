//
//  RoomGridView.h
//  Together
//
//  Created by Gnef_jp on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

@interface RoomGridView : UIView
{
    __weak IBOutlet UILabel *_noLocationLabel;
    RoomType                _roomType;
    NSInteger               _range;
}

- (void) refreshGrid;

@end
