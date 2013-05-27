//
//  GridBottomView.h
//  MaxDoodle
//
//  Created by gnef_jp on 13-1-4.
//  Copyright (c) 2013年 appletree. All rights reserved.
//

typedef enum
{
    GridBottomViewState_LoadMore = 1,       // 显示Load More按钮
    GridBottomViewState_Loading  = 2,       // 正在装载
    GridBottomViewState_Finish   = 3,       // 已经是最后的了
} GridBottomViewState;

@interface GridBottomView : UIView
{
    IBOutlet UIActivityIndicatorView*   _loadingView;
    IBOutlet UILabel*                   _msgLabel;
}

@property (assign, nonatomic)   GridBottomViewState     state;
@property (retain, nonatomic)   UIColor*                loadingColor;

- (void) hideMsg:(BOOL)isHideMsg;

@end
