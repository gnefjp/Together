//
//  Annotation.h
//  CustomAnnotation
//
//  Created by akshay on 8/14/12.
//  Copyright (c) 2012 raw engineering, inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>

@property (readonly, nonatomic)  CLLocationCoordinate2D coordinate;
@property (copy, nonatomic)      NSString *title;
@property (copy, nonatomic)      NSString *subtitle;
@property (assign, nonatomic)    NSString *locationType;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
@end
