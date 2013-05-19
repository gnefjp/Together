//
//  RoomMapView.h
//  Together
//
//  Created by APPLE on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "CustomAnnotationView.h"
#import "NetRoomList.h"

@interface RoomMapView : UIView<MKMapViewDelegate>
{
     IBOutlet MKMapView             *_iMapView;
     NetRoomList                    *_showListArr;
     NSMutableArray                 *_anonations;
     CustomAnnotationView           *_selectAnnotation;
}

@property (strong, nonatomic) NetRoomList    *showListArr;

- (void)reloadMapData:(NetRoomList*)aList;
- (IBAction)closeBtnDidPressed:(id)sender;

@end
