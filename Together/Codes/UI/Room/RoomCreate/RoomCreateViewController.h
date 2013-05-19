//
//  RoomCreateViewController.h
//  Together
//
//  Created by Gnef_jp on 13-4-25.
//  Copyright (c) 2013年 GMET. All rights reserved.
//
#import "PicChange.h"

#import "FileUploadRequest.h"
#import "RoomCreateRequest.h"

#import "RecorderView.h"

@class RoomTypePickerView;
@class NetRoomItem;
@interface RoomCreateViewController : UIViewController <UITableViewDelegate,
                                                        UITableViewDataSource,
                                                        PicChangeDelegate,
                                                        NetFileRequestDelegate,
                                                        NetRoomRequestDelegate,
                                                        RecorderViewDelegate>
{
    __weak IBOutlet UITableView *_infoTableView;
    
    __weak IBOutlet UIButton    *_createButton;
    __weak IBOutlet UIView      *_recordView;
    
    UIDatePicker                *_datePickerView;
    RoomTypePickerView          *_roomTypePickerView;
    
    NetRoomItem                 *_roomInfo;
    BOOL                        _hasPickRoomType;
    
    PicChange                   *_picChange;
    __weak IBOutlet UIImageView *_previewImageView;
    
    RecorderView                *_recorderView;
}

- (IBAction)closeBtnPressed:(id)sender;
- (IBAction)roomTypeBtnPressed:(id)sender;

- (IBAction)createBtnPressed:(id)sender;

- (IBAction)backToCreateView:(id)sender;

- (IBAction)pickPicDidPressed:(id)sender;
@end
