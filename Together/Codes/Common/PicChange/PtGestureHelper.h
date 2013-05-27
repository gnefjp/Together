//
//  PtGestureHelper.h
//  KidsPainting
//
//  Created by HJC on 11-10-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PtGestureHelper : NSObject<UIGestureRecognizerDelegate>
{
@private
    UIView*             _viewAttached;
    UIView*             _viewNeedChanged;
    
    CGFloat             _scale;
    CGPoint             _translation;
    CGFloat             _rotation;
    
    CGPoint             _beginTranslation;
    CGFloat             _beginScale;
    CGFloat             _beginRotation;
    
    CGFloat             _initScale;

    NSInteger           _numberOfTouchesRequired;
    
    NSMutableArray*     _gestures;
}

@property (nonatomic, assign)   UIView*     viewNeedChanged;
@property (nonatomic, assign)   NSInteger   numberOfTouchesRequired;
@property (nonatomic, assign)   CGFloat     initScale;


- (id) initWithAttached:(UIView*)attachedView 
            needChanged:(UIView*)viewNeedChanged;

- (void) restoreDefaultAnimated:(BOOL)animated;


- (CGAffineTransform) makeTransform;

- (void) attachPinchGesture;
- (void) attachPanGesture;
- (void) attachDoubleTapGesture;
- (void) attachRotationGesture;

- (void) disableGestures;
- (void) enableGestures;

@end
