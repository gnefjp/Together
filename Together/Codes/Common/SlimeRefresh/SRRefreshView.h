//
//  SRRefreshView.h
//  SlimeRefresh
//
//  A refresh view looks like UIRefreshControl
//
//  Created by apple on 12-6-15.
//  Copyright (c) 2012年 zrz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRSlimeView.h"

@protocol SRRefreshDelegate;

@interface SRRefreshView : UIView{
    UIImageView     *_refleshView;
    SRSlimeView     *_slime;
}

//set the state loading or not.
@property (nonatomic, assign)   BOOL    loading;
//set the slime's style by this property.
@property (nonatomic, strong, readonly) SRSlimeView *slime;
//set your refresh icon.
@property (nonatomic, strong, readonly) UIImageView *refleshView;
@property (nonatomic, assign)   id<SRRefreshDelegate>   delegate;

// 
@property (nonatomic, assign)   CGFloat upInset;

//
- (void)scrollViewDidScroll;
- (void)scrollViewDidEndDraging;

//
- (void)endRefresh;

@end

@protocol SRRefreshDelegate <NSObject>

@optional
//start refresh.
- (void)slimeRefreshStartRefresh:(SRRefreshView*)refreshView;

@end