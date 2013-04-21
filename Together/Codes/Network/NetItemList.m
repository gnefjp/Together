//
//  NetItemList.m
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetItemList.h"


#pragma mark- Item
@implementation NetItem

+ (NetItem *) itemWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


// 子类重写
- (NetItem *) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.ID = [dict valueForKey:@"ID"];
    }
    return self;
}


// 子类重写
- (void) refreshItem:(NetItem*)newItem
{
}

@end


#pragma mark- List
@implementation NetItemList

- (id) init
{
    self = [super init];
    if (self)
    {
        _list = [[NSMutableArray alloc] init];
        _dict = [[NSMutableDictionary alloc] init];
    }
    return self;
}


- (NSInteger) indexOfItemId:(NSString*)itemId
{
    for (int i = 0, len = [_list count]; i < len; i++)
    {
        NetItem* item = [_list objectAtIndex:i];
        if ([item.ID isEqualToString:itemId])
        {
            return i;
        }
    }
    return -1;
}


- (NetItem*) itemAtId:(NSString*)ID
{
    return [_dict objectForKey:ID];
}


- (NetItem*) itemAtIndex:(NSInteger)index
{
    return [_list objectAtIndex:index];
}


- (BOOL) addItemAtFirst:(NetItem*)item
{
    return [self insertItem:item atIndex:0];
}


- (BOOL) addItem:(NetItem*)item
{
    return [self insertItem:item atIndex:_list.count];
}


- (BOOL) insertItem:(NetItem*)item atIndex:(NSInteger)index
{
    if (index < 0 || index > _list.count)
    {
        return NO;
    }
    
    if ([_dict objectForKey:item.ID] == nil)
    {
        [_dict setObject:item forKey:item.ID];
        [_list insertObject:item atIndex:index];
        return YES;
    }
    return NO;
}


// 子类重写
- (NSArray *) _decodeData:(NSDictionary *)dict
{
    return nil;
}


- (void) addItemList:(NSDictionary*)dict onPage:(NSInteger)page
{
    if (page != _nextPageIndex)
    {
        _nextPageIndex = page;
    }
    
    NSArray* tmpList = [self _decodeData:dict];
    
    if (tmpList != nil)
    {
        if (page == 0)
        {
            [_list removeAllObjects];
            [_dict removeAllObjects];
        }
        
        for (int idx = 0, len = [tmpList count]; idx < len; idx++)
        {
            NetItem* item = (NetItem*) [tmpList objectAtIndex:idx];
            
            if ([_dict objectForKey:item.ID] == nil)
            {
                [_list addObject:item];
                [_dict setObject:item forKey:item.ID];
            }
        }
        
        _nextPageIndex ++;
    }
}


- (void) replaceItem:(NetItem*)item
{
    NetItem* oldItem = [_dict objectForKey:item.ID];
    if (oldItem)
    {
        [oldItem refreshItem:item];
    }
}


- (void) removeItemById:(NSString*)ID
{
    for (int idx = 0, len = [_list count]; idx < len; idx++)
    {
        if ([[self itemAtIndex:idx].ID isEqualToString:ID])
        {
            [_list removeObjectAtIndex:idx];
            [_dict removeObjectForKey:ID];
            return;
        }
    }
}


- (void) removeAllItems
{
    [_list removeAllObjects];
    [_dict removeAllObjects];
    _nextPageIndex = 0;
    _isFinish = NO;
}

@end
