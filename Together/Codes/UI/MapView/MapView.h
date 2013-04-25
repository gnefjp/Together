//
//  MapView.h
//  Together
//
//  Created by APPLE on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotationView.h>
#import "CustomAnnotationView.h"
#import "Annotation.h"

@class MapView;

@protocol MapViewDelegate <NSObject>

- (void)MapView:(MapView*)view location:(CLLocationCoordinate2D)aLocation;

@end

@interface MapView : UIView<CLLocationManagerDelegate>
{
    __weak IBOutlet MKMapView       *_iMapView;
    CLLocationManager               *_locationManager;
    BOOL                            *_isAdd;
    Annotation                      *_choosePosition;
    __weak id<MapViewDelegate>      _delegate;
}

@property (weak ,nonatomic) __weak id<MapViewDelegate>    delegate;

- (void)showAnimation;
- (IBAction)closeBtnDidPressed:(id)sender;
- (IBAction)getCurrentChoosePosition:(id)sender;
- (IBAction)currentLocation:(id)sender;

@end
