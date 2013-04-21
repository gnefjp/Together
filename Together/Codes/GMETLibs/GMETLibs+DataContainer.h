//
//  GMETLibs+DataContainer.h
//  Together
//
//  Created by Gnef_jp on 13-4-21.
//  Copyright (c) 2013年 GMET. All rights reserved.
//


#pragma mark- NSMutableDictionary
@interface NSMutableDictionary(GMETLibs)

- (void) saveBool:(BOOL)value forKey:(NSString*)key;
- (BOOL) loadBoolForKey:(NSString*)key defaultValue:(BOOL)value;

- (void) saveInteger:(NSInteger)value forKey:(NSString*)key;
- (NSInteger) loadIntegerForKey:(NSString*)key defaultValue:(NSInteger)value;

- (void) saveFloat:(float)value forKey:(NSString*)key;
- (float) loadFloat:(NSString*)key defaultValue:(float)value;

- (void) saveDouble:(double)value forKey:(NSString*)key;
- (double) loadDouble:(NSString*)key defaultValue:(double)value;

- (void) saveString:(NSString*)value forKey:(NSString*)key;
- (NSString*) loadStringForKey:(NSString*)key defaultValue:(NSString*)value;

@end



#pragma mark- NSUserDefaults
@interface NSUserDefaults(GMETLibs)

+ (void) saveBool:(BOOL)value forKey:(NSString*)key;
+ (BOOL) loadBoolForKey:(NSString*)key defaultValue:(BOOL)value;

+ (void) saveInteger:(NSInteger)value forKey:(NSString*)key;
+ (NSInteger) loadIntegerForKey:(NSString*)key defaultValue:(NSInteger)value;

+ (void) saveFloat:(float)value forKey:(NSString*)key;
+ (float) loadFloat:(NSString*)key defaultValue:(float)value;

+ (void) saveDouble:(double)value forKey:(NSString*)key;
+ (double) loadDouble:(NSString*)key defaultValue:(double)value;

+ (void) saveString:(NSString*)value forKey:(NSString*)key;
+ (NSString*) loadStringForKey:(NSString*)key defaultValue:(NSString*)value;

@end