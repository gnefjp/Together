//
//  NetItemList.h
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "Response.pb.h"

#pragma mark- Item
@interface NetItem : NSObject

@property (strong, nonatomic) NSString  *ID;

+ (NetItem *) itemWithMessage:(PBGeneratedMessage *)message;
- (NetItem *) initWithMessage:(PBGeneratedMessage *)message;

// 地址一样，内容更新
- (void) refreshItem:(NetItem*)newItem;

@end


#pragma mark- List
@interface NetItemList : NSObject
{
    NSMutableArray          *_list;
    NSMutableDictionary     *_dict;
}

@property (strong, nonatomic) NSArray       *list;
@property (assign, nonatomic) NSInteger     nextPageIndex;
@property (assign, nonatomic) BOOL          isFinish;

// 子类必须重写解释数据方法
// - (NSArray *) _decodeData:(HTTPResponse *)response

- (NSInteger) indexOfItemId:(NSString*)itemId;

- (NetItem*) itemAtId:(NSString*)ID;
- (NetItem*) itemAtIndex:(NSInteger)index;

- (BOOL) addItemAtFirst:(NetItem*)item;
- (BOOL) addItem:(NetItem*)item;
- (BOOL) insertItem:(NetItem*)item atIndex:(NSInteger)index;
- (void) addItemList:(HTTPResponse *)response onPage:(NSInteger)page;

- (void) replaceItem:(NetItem*)item;
- (void) removeItemById:(NSString*)ID;
- (void) removeAllItems;

@end
