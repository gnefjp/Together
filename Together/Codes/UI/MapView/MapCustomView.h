//
//  MapCustomView.h
//  CustomAnnotation
//
//  Created by APPLE on 13-4-24.
//
//

#import <UIKit/UIKit.h>
#import "NetRoomList.h"

@interface MapCustomView : UIView
{
    
}



@property (weak, nonatomic)   IBOutlet UIImageView      *iRoomImg;
@property (weak, nonatomic)   IBOutlet UILabel          *iCreator;
@property (weak, nonatomic)   IBOutlet UILabel          *iStarDate;
@property (weak, nonatomic)   IBOutlet UILabel          *iPeopleCount;
@property (strong, nonatomic) NetRoomItem               *roomItem;

- (void) refreshRomm:(NetRoomItem*)roomItem;
- (IBAction)createRoomController:(id)sender;

@end
