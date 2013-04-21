//
//  GMETLibs+DataContainer.m
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#pragma mark- NSMutableDictionary
@implementation NSMutableDictionary(GMETLibs)

- (void) saveBool:(BOOL)value forKey:(NSString*)key
{
    [self setValue:[NSNumber numberWithBool:value] forKey:key];
}


- (BOOL) loadBoolForKey:(NSString*)key defaultValue:(BOOL)value
{
    NSNumber* num = [self objectForKey:key];
    if (num == nil)
    {
        return value;
    }
    return [num boolValue];
}


- (void) saveInteger:(NSInteger)value forKey:(NSString*)key
{
    [self setValue:[NSNumber numberWithInteger:value] forKey:key];
}


- (NSInteger) loadIntegerForKey:(NSString*)key defaultValue:(NSInteger)value
{
    NSNumber* num = [self objectForKey:key];
    if (num == nil)
    {
        return value;
    }
    return [num integerValue];
}



- (void) saveFloat:(float)value forKey:(NSString*)key
{
    [self setValue:[NSNumber numberWithFloat:value] forKey:key];
}


- (float) loadFloat:(NSString*)key defaultValue:(float)value
{
    NSNumber* num = [self objectForKey:key];
    if (num == nil)
    {
        return value;
    }
    return [num floatValue];
}


- (void) saveDouble:(double)value forKey:(NSString*)key
{
    [self setValue:[NSNumber numberWithDouble:value] forKey:key];
}


- (double) loadDouble:(NSString*)key defaultValue:(double)value
{
    NSNumber* num = [self objectForKey:key];
    if (num == nil)
    {
        return value;
    }
    return [num doubleValue];
}


- (void) saveString:(NSString*)value forKey:(NSString*)key
{
    [self setValue:value forKey:key];
}


- (NSString*) loadStringForKey:(NSString*)key defaultValue:(NSString*)value
{
    NSString* str = [self objectForKey:key];
    if (str == nil)
    {
        return value;
    }
    return str;
}

@end


#pragma mark- NSUserDefaults
@implementation NSUserDefaults(GMETLibs)


+ (void) saveBool:(BOOL)value forKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:value]
                                             forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (BOOL) loadBoolForKey:(NSString*)key defaultValue:(BOOL)value
{
    NSNumber* num = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (num == nil)
    {
        return value;
    }
    return [num boolValue];
}


+ (void) saveInteger:(NSInteger)value forKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInteger:value]
                                             forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSInteger) loadIntegerForKey:(NSString*)key defaultValue:(NSInteger)value
{
    NSNumber* num = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (num == nil)
    {
        return value;
    }
    return [num integerValue];
}



+ (void) saveFloat:(float)value forKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:value] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (float) loadFloat:(NSString*)key defaultValue:(float)value
{
    NSNumber* num = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (num == nil)
    {
        return value;
    }
    return [num floatValue];
}


+ (void) saveDouble:(double)value forKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithDouble:value] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (double) loadDouble:(NSString*)key defaultValue:(double)value
{
    NSNumber* num = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (num == nil)
    {
        return value;
    }
    return [num doubleValue];
}


+ (void) saveString:(NSString*)value forKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString*) loadStringForKey:(NSString*)key defaultValue:(NSString*)value
{
    NSString* str = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (str == nil)
    {
        return value;
    }
    return str;
}

@end
