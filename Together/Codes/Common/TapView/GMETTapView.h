//
//  GMETTapView.h
//  Together
//
//  Created by Gnef_jp on 13-4-25.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

@class GMETTapView;
@protocol GMETTapViewDelegate <NSObject>

- (void) GMETTapView:(GMETTapView *)tapView touchBegin:(UIEvent *)event;
- (void) GMETTapView:(GMETTapView *)tapView touchEnded:(UIEvent *)event;

@end

@interface GMETTapView : UIView
{
    __weak id <GMETTapViewDelegate>        _delegate;
}

@property (weak,   nonatomic) id        delegate;
@property (assign, nonatomic) BOOL      isIgnoreTap;

@end
