//
//  CustomAnnotationView.h
//  CustomAnnotation
//
//  Created by akshay on 8/17/12.
//  Copyright (c) 2012 raw engineering, inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MapCustomView.h"

@interface CustomAnnotationView : MKPinAnnotationView
{
    MapCustomView           *_mapView;
}

@property (strong, nonatomic) UIImageView             *calloutView;
@property (strong, nonatomic) MapCustomView           *mapView;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end