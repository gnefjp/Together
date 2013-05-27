//
//  CustomAnnotationView.m
//  CustomAnnotation
//
//  Created by akshay on 8/17/12.
//  Copyright (c) 2012 raw engineering, inc. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "Annotation.h"
#import <QuartzCore/QuartzCore.h>

#define Arror_height 16

@implementation CustomAnnotationView
@synthesize mapCellView = _mapCellView;

@synthesize calloutView;

- (id) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.canShowCallout = NO;
        _mapCellView = [MapCustomView loadFromNib];
        self.frame = CGRectMake(0, 0, _mapCellView.frame.size.width, _mapCellView.frame.size.height + Arror_height);
        [self addSubview:_mapCellView];
        [_mapCellView setHidden:YES];
        _mapCellView.center = CGPointMake(-10, -10);
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    Annotation *ann = self.annotation;
    if(selected)
    {
        [_mapCellView setHidden:NO];
        [_mapCellView refreshRomm:ann.roomInfo];
    }
    else
    {
        [_mapCellView setHidden:YES];
    }
}

- (void)didAddSubview:(UIView *)subview{

}

@end
