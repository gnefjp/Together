//
//  InfoFillInViewController.h
//  Together
//
//  Created by Gnef_jp on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "MapView.h"

typedef enum
{
    InfoFillType_TextField  = 0,
    InfoFillType_TextView   = 1,
    InfoFillType_Picker     = 2,
    InfoFillType_Map        = 3,
    
    InfoFillType_Max        = 4,
} InfoFillType;


@class InfoFillInViewController;
@protocol InfoFillInViewControllerDelegate <NSObject>
- (void) InfoFillInViewController:(InfoFillInViewController *)controller fillValue:(NSString *)fillValue;

@optional
- (void) InfoFillInViewController:(InfoFillInViewController *)controller
                      addLocation:(CLLocationCoordinate2D)location
                       detailAddr:(NSString *)detailAddr;
@end


@interface InfoFillInViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate,
                                                        UITableViewDelegate, UITableViewDataSource,
                                                        MapViewDelegate>
{
    __weak id <InfoFillInViewControllerDelegate>    _delegate;
    
    __weak IBOutlet UIButton                        *_confirmBtn;
    
    __weak IBOutlet UIImageView                     *_inputBgImageView;
    __weak IBOutlet UIView                          *_inputLengthView;
    __weak IBOutlet UILabel                         *_inputLengthLabel;
    
    __weak IBOutlet UITextField                     *_textField;
    __weak IBOutlet UITextView                      *_textView;
    __weak IBOutlet UITableView                     *_tableView;
    
    MapView                                         *_mapView;
    
    UIPanGestureRecognizer                          *_panGesture;
}


@property (weak,   nonatomic) id                delegate;
@property (weak,   nonatomic) IBOutlet UILabel  *titleLabel;
@property (assign, nonatomic) InfoFillType      fillType;
@property (strong, nonatomic) NSArray           *dataList;
@property (assign, nonatomic) int               textMaxLength;

- (IBAction)cancelBtnPressed:(id)sender;
- (IBAction)confirmBtnPressed:(id)sender;

- (void) textValue:(NSString *)text;
- (IBAction)clearText:(id)sender;
@end
