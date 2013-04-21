//
//  GMETLibs+UIView.h
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#pragma mark- ViewControl
@interface UIViewController (GMETLibs)

+ (id) loadFromNibNamed:(NSString*)name;
+ (id) loadFromNib;

@end


#pragma mark- View
@interface UIView (GMETLibs)

@property (assign, nonatomic) CGPoint   frameOrigin;
@property (assign, nonatomic) CGFloat   frameX;
@property (assign, nonatomic) CGFloat   frameY;

@property (assign, nonatomic) CGSize    boundsSize;
@property (assign, nonatomic) CGFloat   boundsHeight;   
@property (assign, nonatomic) CGFloat   boundsWidth;


+ (id) loadFromNibNamed:(NSString*)name isKindOf:(Class)cls;
+ (id) loadFromNibNamed:(NSString*)name;
+ (id) loadFromNib;


// 查找属于cls类的子view, 另外可以指定是否递归遍历
- (id)  viewIsKindOf:(Class)cls recursive:(BOOL)recursive;

// 查找指定tag的子view
- (id)  viewWithTag:(NSInteger)tag recursive:(BOOL)recursive;


// 将view上面的内容转成图片, 这函数只能在主线程中调用
- (UIImage*) renderToImage;

@end
