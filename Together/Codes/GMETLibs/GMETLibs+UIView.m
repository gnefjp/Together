//
//  GMETLibs+UIView.m
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GMETLibs+UIView.h"

#pragma mark- UIViewControl
@implementation UIViewController (GMETLibs)

+ (id) loadFromNibNamed:(NSString*)name
{
    return [[self alloc] initWithNibName:name bundle:nil];
}


+ (id) loadFromNib
{
    NSString* clsName = NSStringFromClass(self);
    return [[self alloc] initWithNibName:clsName bundle:nil];
}

@end



#pragma mark- UIView
@implementation UIView (GMETLibs)

#pragma mark- Frame & Bounds
- (CGPoint) frameOrigin
{
    return self.frame.origin;
}

- (void) setFrameOrigin:(CGPoint)frameOrigin
{
    self.frame = CGRectMake(frameOrigin.x, frameOrigin.y, self.boundsWidth, self.boundsHeight);
}


- (CGFloat) frameX
{
    return self.frameOrigin.x;
}

- (void) setFrameX:(CGFloat)frameX
{
    self.frame = CGRectMake(frameX, self.frameY, self.boundsWidth, self.boundsHeight);
}


- (CGFloat) frameY
{
    return self.frameOrigin.y;
}

- (void) setFrameY:(CGFloat)frameY
{
    self.frame = CGRectMake(self.frameX, frameY, self.boundsWidth, self.boundsHeight);
}


- (CGSize) boundsSize
{
    return self.bounds.size;
}

- (void) setBoundsSize:(CGSize)boundsSize
{
    self.bounds = CGRectMake(0, 0, boundsSize.width, boundsSize.height);
}


- (CGFloat) boundsWidth
{
    return self.boundsSize.width;
}

- (void) setBoundsWidth:(CGFloat)boundsWidth
{
    self.bounds = CGRectMake(0, 0, boundsWidth, self.boundsHeight);
}


- (CGFloat) boundsHeight
{
    return self.boundsSize.height;
}

- (void) setBoundsHeight:(CGFloat)boundsHeight
{
    self.bounds = CGRectMake(0, 0, self.boundsWidth, boundsHeight);
}


#pragma mark- loadView
+ (id) loadFromNibNamed:(NSString*)name isKindOf:(Class)cls
{
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:0];
    for (NSObject* object in array)
    {
        if ([object isKindOfClass:cls])
        {
            return object;
        }
    }
    return nil;
}


+ (id) loadFromNibNamed:(NSString*)name
{
    return [self loadFromNibNamed:name isKindOf:self];
}


+ (id) loadFromNib
{
    NSString* clsName = NSStringFromClass(self);
    return [self loadFromNibNamed:clsName isKindOf:self];
}

+ (UIView*)rootView
{
    UIWindow *keyWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
    return keyWindow.rootViewController.view;
}

+ (UINavigationController*) rootController
{
    UIWindow *keyWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
    return (UINavigationController *)keyWindow.rootViewController;
}


#pragma mark- subview
- (id)  viewIsKindOf:(Class)cls recursive:(BOOL)recursive
{
    for (UIView* aView in self.subviews)
    {
        if ([aView isKindOfClass:cls])
        {
            return aView;
        }
    }
    
    if (recursive)
    {
        for (UIView* aView in self.subviews)
        {
            UIView* findView = [aView viewIsKindOf:cls recursive:YES];
            if (findView)
            {
                return findView;
            }
        }
    }
    return nil;
}


- (id)  viewWithTag:(NSInteger)tag recursive:(BOOL)recursive
{
    if (recursive)
    {
        return [self viewWithTag:tag];
    }
    
    for (UIView* aView in self.subviews)
    {
        if (aView.tag == tag)
        {
            return aView;
        }
    }
    return nil;
}


#pragma mark- ToImage
- (UIImage*) renderToImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
