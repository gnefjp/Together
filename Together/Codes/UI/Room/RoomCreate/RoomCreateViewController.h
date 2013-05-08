//
//  RoomCreateViewController.h
//  Together
//
//  Created by Gnef_jp on 13-4-25.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "PicChange.h"

@class RoomTypePickerView;
@class NetRoomItem;
@interface RoomCreateViewController : UIViewController <UITableViewDelegate,
                                                        UITableViewDataSource,
                                                        PicChangeDelegate>
{
    __weak IBOutlet UITableView *_infoTableView;
    
    __weak IBOutlet UIButton    *_createButton;
    __weak IBOutlet UIView      *_recordView;
    __weak IBOutlet UIView      *_confirmView;
    
    UIDatePicker                *_datePickerView;
    RoomTypePickerView          *_roomTypePickerView;
    
    NetRoomItem                 *_roomInfo;
    BOOL                        _hasPickRoomType;
    
    PicChange                   *_picChange;
    __weak IBOutlet UIImageView *_previewImageView;
}

- (IBAction)closeBtnPressed:(id)sender;
- (IBAction)roomTypeBtnPressed:(id)sender;

- (IBAction)createBtnPressed:(id)sender;

- (IBAction)backToCreateView:(id)sender;
- (IBAction)startRecord:(id)sender;
- (IBAction)confirmRecord:(id)sender;
- (IBAction)cancelRecord:(id)sender;

- (IBAction)backToRecord:(id)sender;
- (IBAction)playOrStopRecord:(id)sender;
- (IBAction)confirmToCreate:(id)sender;

- (IBAction)pickPicDidPressed:(id)sender;
@end
