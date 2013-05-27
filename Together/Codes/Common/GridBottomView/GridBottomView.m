//
//  GridBottomView.m
//  MaxDoodle
//
//  Created by gnef_jp on 13-1-4.
//  Copyright (c) 2013年 appletree. All rights reserved.
//

#import "GridBottomView.h"

@implementation GridBottomView


- (void) awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    
    _state = GridBottomViewState_LoadMore;
    
    _loadingView.boundsSize = CGSizeMake(42.0, 42.0);
}


- (void) hideMsg:(BOOL)isHideMsg
{
    _msgLabel.hidden = isHideMsg;
}


- (void) setState:(GridBottomViewState)state
{
    _state = state;
    _loadingView.hidden = (state != GridBottomViewState_Loading);
    
    switch (state)
    {
        case GridBottomViewState_Loading:
        {
            [_loadingView startAnimating];
            self.boundsHeight = 86;
            _msgLabel.frameOrigin = CGPointMake(20, 50);
            _msgLabel.text = @"正在加载";
            break;
        }
        case GridBottomViewState_LoadMore:
        case GridBottomViewState_Finish:
        {
            [_loadingView stopAnimating];
            self.boundsHeight = 50;
            _msgLabel.frameOrigin = CGPointMake(20, 10);
            _msgLabel.text = @"已经是最后的了";
            break;
        }
        default:
            break;
    }
}


- (void) setLoadingColor:(UIColor *)loadingColor
{
    if (_loadingColor != loadingColor)
    {
        _loadingColor = loadingColor;
    }
    
    _loadingView.color = _loadingColor;
}

@end
