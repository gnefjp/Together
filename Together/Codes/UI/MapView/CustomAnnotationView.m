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
@synthesize mapView = _mapView;

@synthesize calloutView;

- (id) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.canShowCallout = NO;
        _mapView = [[[NSBundle mainBundle] loadNibNamed:@"MapCustomView" owner:nil options:0] objectAtIndex:0];
        self.frame = CGRectMake(0, 0, _mapView.frame.size.width, _mapView.frame.size.height + Arror_height);
        [self addSubview:_mapView];
        [_mapView setHidden:YES];
        _mapView.center = CGPointMake(-10, -10);
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];

    Annotation *ann = self.annotation;
    if(selected)
    {
        
        [_mapView setHidden:NO];
        //Add your custom view to self...
        if ([ann.locationType isEqualToString:@"airport"])
        {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"airport.png"]];
            _mapView._iTypeImage.image = [UIImage imageNamed:@"airport.png"];
            _mapView._iLb.text = @"airPort";
        }
        if ([ann.locationType isEqualToString:@"restaurant"])
        {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"restaurant.png"]];
            _mapView._iTypeImage.image = [UIImage imageNamed:@"restaurant"];
            _mapView._iLb.text = @"restaurant";
        }
        if ([ann.locationType isEqualToString:@"shopping"])
        {
            _mapView._iTypeImage.image = [UIImage imageNamed:@"shopping.png"];
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopping.png"]];
            _mapView._iLb.text = @"shopping";
        }
        
    }
    else
    {
        [_mapView setHidden:YES];
        [calloutView removeFromSuperview];
    }
}

- (void)didAddSubview:(UIView *)subview{
    Annotation *ann = self.annotation;
    if (![ann.locationType isEqualToString:@"dropped"]) {
        if ([[[subview class] description] isEqualToString:@"UICalloutView"]) {
            for (UIView *subsubView in subview.subviews) {
                if ([subsubView class] == [UIImageView class]) {
                    UIImageView *imageView = ((UIImageView *)subsubView);
                    [imageView removeFromSuperview];
                }else if ([subsubView class] == [UILabel class]) {
                    UILabel *labelView = ((UILabel *)subsubView);
                    [labelView removeFromSuperview];
                }
            }
        }
    }
}


//- (void)animateCalloutAppearance {
//    CGFloat scale = 0.001f;
//    calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
//    
//    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
//        CGFloat scale = 1.1f;
//        calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
//            CGFloat scale = 0.95;
//            calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.075 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
//                CGFloat scale = 1.0;
//                calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
//            } completion:nil];
//        }];
//    }];
//}

@end
