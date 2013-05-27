//
//  MapCustomView.m
//  CustomAnnotation
//
//  Created by APPLE on 13-4-24.
//
//

#import "MapCustomView.h"
#import "CommonTool.h"
#import "RoomViewController.h"

@implementation MapCustomView
@synthesize roomItem = _roomItem;

- (void) refreshRomm:(NetRoomItem*)roomItem
{
    [_iRoomImg setImageWithFileID:roomItem.perviewID placeholderImage:[UIImage imageNamed:@"room_create_pic_frame.png"]];
    _iCreator.text = roomItem.roomTitle;
    _iStarDate.text = roomItem.beginTime;
    if (roomItem.personLimitNum<1) {
         _iPeopleCount.text = [NSString stringWithFormat:@"%d/不限",roomItem.joinPersonNum];
    }else
    {
        _iPeopleCount.text = [NSString stringWithFormat:@"%d/%d",roomItem.joinPersonNum,roomItem.personLimitNum];
    }
}

- (IBAction)createRoomController:(id)sender
{
    RoomViewController *roomViewController = [RoomViewController loadFromNib];
    
    [[UIView rootController] pushViewController:roomViewController animated:YES];
    roomViewController.roomItem = self.roomItem;
}

@end
