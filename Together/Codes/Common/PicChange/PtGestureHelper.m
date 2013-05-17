//
//  PtGestureHelper.m
//  KidsPainting
//
//  Created by HJC on 11-10-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PtGestureHelper.h"


@implementation PtGestureHelper
@synthesize viewNeedChanged = _viewNeedChanged;
@synthesize numberOfTouchesRequired = _numberOfTouchesRequired;
@synthesize initScale = _initScale;



- (id) initWithAttached:(UIView*)attachedView 
            needChanged:(UIView*)viewNeedChanged
{
    self = [super init];
    if (self)
    {
        _scale = 1.0f;
        _initScale = 1.0f;
        _numberOfTouchesRequired = 1;
        _viewAttached = attachedView;
        _viewNeedChanged = viewNeedChanged;
        _gestures = [[NSMutableArray alloc] initWithCapacity:4];
    }
    return self;
}



- (void) dealloc
{
    for (UIGestureRecognizer* recognizer in _gestures)
    {
        [_viewAttached removeGestureRecognizer:recognizer];
    }
    [_gestures release];
    [super dealloc];
}




- (void) attachPinchGesture
{
    UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(_pinchHappen:)];
    pinchRecognizer.delegate = self;
    [_viewAttached addGestureRecognizer:pinchRecognizer];
    [_gestures addObject:pinchRecognizer];
    [pinchRecognizer release];
}



- (void) attachPanGesture
{
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(_panHappen:)];
    panRecognizer.delegate = self;
    panRecognizer.minimumNumberOfTouches = _numberOfTouchesRequired;
    [_viewAttached addGestureRecognizer:panRecognizer];
    [_gestures addObject:panRecognizer];
    [panRecognizer release];
}


- (void) attachDoubleTapGesture
{
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(_doubleTapHappen:)];
    tapRecognizer.delegate = self;
    tapRecognizer.numberOfTapsRequired = 2;
    tapRecognizer.numberOfTouchesRequired = _numberOfTouchesRequired;
    [_viewAttached addGestureRecognizer:tapRecognizer];
    [_gestures addObject:tapRecognizer];
    [tapRecognizer release];
}



- (void) attachRotationGesture
{
    UIRotationGestureRecognizer* rotationRecognizer = [[UIRotationGestureRecognizer alloc] 
                                                       initWithTarget:self
                                                       action:@selector(_rotationHappen:)];
    rotationRecognizer.delegate = self;
    [_viewAttached addGestureRecognizer:rotationRecognizer];
    [_gestures addObject:rotationRecognizer];
    [rotationRecognizer release];
}



- (void) disableGestures
{
    for (UIGestureRecognizer* recognizer in _gestures)
    {
        recognizer.enabled = NO;
    }
}


- (void) enableGestures
{
    for (UIGestureRecognizer* recognizer in _gestures)
    {
        recognizer.enabled = YES;
    }
}


- (CGAffineTransform) makeTransform
{
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    transform = CGAffineTransformTranslate(transform, _translation.x, _translation.y);
    transform = CGAffineTransformScale(transform, _scale * _initScale, _scale * _initScale);
    transform = CGAffineTransformRotate(transform, _rotation);
    return transform;
}


- (void) _pinchHappen:(UIPinchGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        _beginScale = _scale;
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (_scale > 4)     _scale = 4;
        if (_scale < 0.5)   _scale = 0.5;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        
        _viewNeedChanged.transform = [self makeTransform];
        
        [UIView commitAnimations];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGFloat scale = recognizer.scale;
        _scale = _beginScale * scale;
        _viewNeedChanged.transform = [self makeTransform];
    }
}


- (void) _panHappen:(UIPanGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        _beginTranslation = _translation;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint trans = [recognizer translationInView:recognizer.view];
        _translation.x = _beginTranslation.x + trans.x;
        _translation.y = _beginTranslation.y + trans.y;
        _viewNeedChanged.transform = [self makeTransform];
    }
}



- (void) _rotationHappen:(UIRotationGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        _beginRotation = _rotation;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGFloat rotation = recognizer.rotation;
        _rotation = _beginRotation + rotation;
        _viewNeedChanged.transform = [self makeTransform];
    }
}


- (void) restoreDefaultAnimated:(BOOL)animated
{
    _scale = 1.0f;
    _translation = CGPointMake(0, 0);
    _rotation = 0.0f;
    
    if (animated)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        
        _viewNeedChanged.transform = [self makeTransform];
        
        [UIView commitAnimations];
    }
    else
    {
        _viewNeedChanged.transform = [self makeTransform];
    }
}


- (void) _doubleTapHappen:(UITapGestureRecognizer*)recognizer
{
    [self restoreDefaultAnimated:YES];
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer 
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}




@end
