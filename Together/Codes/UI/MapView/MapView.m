//
//  MapView.m
//  Together
//
//  Created by APPLE on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "MapView.h"
#import "Annotation.h"
#import "CustomAnnotationView.h"
#import "Annotation.h"

@implementation MapView

@synthesize delegate = _delegate;

- (void)awakeFromNib
{
    UILongPressGestureRecognizer *dropPin = [[UILongPressGestureRecognizer alloc] init];
    [dropPin addTarget:self action:@selector(handleLongPress:)];
	dropPin.minimumPressDuration = 0.5;
	[_iMapView addGestureRecognizer:dropPin];
}

- (void)handleLongPress:(UITapGestureRecognizer*)tap
{
    CGPoint touchPoint = [tap locationInView:_iMapView];
    CLLocationCoordinate2D touchMapCoordinate = [_iMapView convertPoint:touchPoint toCoordinateFromView:_iMapView];
    
    [_iMapView removeAnnotation:_choosePosition];
    _choosePosition = [[Annotation alloc]initWithLocation:touchMapCoordinate];
    _choosePosition.title = [NSString stringWithFormat:@""];
    _choosePosition.locationType = @"dropped";
    
    [_iMapView addAnnotation:_choosePosition];
    [_iMapView selectAnnotation:_choosePosition animated:YES];
}

- (IBAction)closeBtnDidPressed:(id)sender
{
    if (!([_delegate respondsToSelector:@selector(MapViewBackActionIsDelegate:)] &&
          [_delegate MapViewBackActionIsDelegate:self]))
    {
        [self hideCenterToRightAnimation];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            NSLog(@"0");
            break;
        case 1:
        {
            
            NSString *str = [alertView textFieldAtIndex:0].text;
            if ([str length] == 0) {
                UIAlertView *aAlert = [[UIAlertView alloc] initWithTitle:nil message:@"没有选择的地点" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
                [[UIView rootView] addSubview:aAlert];
                [aAlert show];
                return;
            }
            [_delegate MapView:self
                      location:_choosePosition.coordinate
                  loactionAddr:str];
            [self hideCenterToRightAnimation];
        }
            break;
        default:
            break;
    }
}

- (IBAction)getCurrentChoosePosition:(id)sender
{
    if (!_choosePosition) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没有选择的地点" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [[UIView rootView] addSubview:alert];
        [alert show];
        return;
    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"输入地址具体描述"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.delegate =self;
    [alert show];
    

}

- (IBAction)currentLocation:(id)sender
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _locationManager.delegate = nil;
    CLLocation *location = [locations objectAtIndex:0];
    [_iMapView setRegion:MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.04,0.04)) animated:YES];
    _iMapView.showsUserLocation = YES;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
//    if ([annotation isKindOfClass:[Annotation class]]){
//        // Try to dequeue an existing pin view first.
//        CustomAnnotationView* pinView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
//        if (!pinView){
//            // If an existing pin view was not available, create one.
//            pinView = [[CustomAnnotationView alloc] initWithAnnotation:annotation
//                                                       reuseIdentifier:@"CustomPinAnnotationView"];
//        }
//        else
//        {
//            pinView.annotation = annotation;
//        }
//        [pinView setPinColor:MKPinAnnotationColorGreen];
//        return pinView;
//    }
//    return nil;
    if ([annotation isKindOfClass:[Annotation class]])
    {
        Annotation *ann = (Annotation*)annotation;
        if ([ann.locationType isEqualToString:@"dropped"]) {
            MKPinAnnotationView *tempView = (MKPinAnnotationView*)[_iMapView dequeueReusableAnnotationViewWithIdentifier:@"choose"];
            if (!tempView) {
                [ann setTitle:@"你选择的地方"];
                tempView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"choose"];
            }
            return tempView;
        }
       
    }
    return nil;
}

@end
