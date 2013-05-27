//
//  GMETLibs+NSString.h
//  Together
//
//  Created by Gnef_jp on 13-4-25.
//  Copyright (c) 2013年 GMET. All rights reserved.
//


@interface NSString (GMETLibs)

+ (NSString*) md5FromBytes:(const void*)bytes length:(NSInteger)length;
- (NSString*) stringByEncodingToMd5;
+ (NSString*) md5FromData:(NSData*)data;

+ (NSString *) stringWithInt:(NSInteger)intValue;
+ (NSString *) stringWithFloat:(float)floatValue;
+ (NSString *) stringWithDouble:(double)doubleValue;

- (NSString *) timestampToDateUsingFormat:(NSString*)format;
- (NSDate *) stringToDateWithFormat:(NSString *)format;

- (int) ageUsingDateFormat:(NSString *)dateFormat;

- (NSString *)URLEncodedString;
- (NSString*)URLDecodedString;

+ (NSDictionary*) urlArgsDictionaryFromString:(NSString*)string;
+ (NSString*)  urlArgsStringFromDictionary:(NSDictionary*)dict;

@end