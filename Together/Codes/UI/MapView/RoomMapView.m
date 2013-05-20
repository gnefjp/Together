//
//  RoomMapView.m
//  Together
//
//  Created by APPLE on 13-5-20.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomMapView.h"

@implementation RoomMapView
@synthesize showListArr = _showListArr;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
    _anonations = [[NSMutableArray alloc] init];
    _iMapView.delegate = self;
    _iMapView.showsUserLocation = YES;
}

- (void)reloadMapData:(NetRoomList*)aList;
{
    [_iMapView removeAnnotations:_anonations];
    for (int i=0;i<aList.list.count;i++)
    {
        Annotation *aNon = [[Annotation alloc]initWithRoomInfo:[aList.list objectAtIndex:i]];
        [_anonations addObject:aNon];
        [_iMapView addAnnotation:aNon];
        if (i==0)
        {
            NetRoomItem *aRoomItem = [aList.list objectAtIndex:i];
            [_iMapView setRegion:MKCoordinateRegionMake(aRoomItem.address.location.coordinate,MKCoordinateSpanMake(0.04, 0.04))];
        }
    }
}

- (IBAction)closeBtnDidPressed:(id)sender
{
    [UIView animateWithDuration:0.4 animations:^(void)
     {
         self.frameOrigin = CGPointMake(320, 0);
     }completion:^(BOOL isFinish)
     {
         [self removeFromSuperview];
     }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[Annotation class]]){
        // Try to dequeue an existing pin view first.
        
        CustomAnnotationView* pinView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            pinView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
        }
        Annotation *ano = (Annotation*)annotation;
        NSString *imageName;
        switch (ano.roomInfo.roomType)
        {
            case RoomType_BRPG:
                imageName = @"map_roomtype_brpg.png";
                break;
            case RoomType_Catering:
                 imageName = @"map_roomtype_catering.png";
                break;
            case RoomType_Sports:
                 imageName = @"map_roomtype_sports.png";
                break;
            case RoomType_Shopping:
                 imageName = @"map_roomtype_shopping.png";
                break;
            case RoomType_Movie:
                 imageName = @"map_roomtype_movie.png";
                break;
            default:
                imageName = @"map_roomtype_other.png";
                break;
        }
        
        pinView.image = [UIImage imageNamed:imageName];
        return pinView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"cababa");
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
//    CGPoint touchPoint = [[touches anyObject] locationInView:self];
////    if (CGRectContainsPoint(_recordFrame, touchPoint))
////    {
////        
////    }
    
}


@end
