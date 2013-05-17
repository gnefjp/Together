//
//  GMETLibs+NSString.m
//  Together
//
//  Created by Gnef_jp on 13-4-25.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GMETLibs+NSString.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (GMETLibs)


+ (NSString*) md5FromBytes:(const void*)bytes length:(NSInteger)length
{
	unsigned char result[16];
	CC_MD5(bytes, length, result );
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
}



- (NSString*) stringByEncodingToMd5
{
    const char *cStr = [self UTF8String];
    return [NSString md5FromBytes:cStr length:strlen(cStr)];
}



+ (NSString*) md5FromData:(NSData*)data
{
    return [self md5FromBytes:data.bytes length:data.length];
}


+ (NSString *) stringWithInt:(NSInteger)intValue
{
    return [NSString stringWithFormat:@"%d", intValue];
}


+ (NSString *) stringWithFloat:(float)floatValue
{
    return [NSString stringWithFormat:@"%f", floatValue];
}


+ (NSString *)stringWithDouble:(double)doubleValue
{
    return [NSString stringWithFormat:@"%lf", doubleValue];
}


- (NSString*) timestampToDateUsingFormat:(NSString*)format
{
    double timestamp = [self doubleValue];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}


- (int) ageUsingDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    
    NSDate *date = [dateFormatter dateFromString:self];
    
    [dateFormatter setDateFormat:@"yyyy"];
    int year = [[dateFormatter stringFromDate:date] intValue];
    
    NSDate *nowDate = [NSDate date];
    int nowYear = [[dateFormatter stringFromDate:nowDate] intValue];
    
    return MAX(0, nowYear - year);
}


- (NSDate *) stringToDateWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:self];
}


- (NSString *)URLEncodedString
{
    NSString *result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
																		   CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8);
	return result;
}


- (NSString*)URLDecodedString
{
	NSString *result = (__bridge NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (CFStringRef)self,
																						   CFSTR(""),
																						   kCFStringEncodingUTF8);
	return result;
}


+ (NSDictionary*) urlArgsDictionaryFromString:(NSString*)string
{
    NSArray* array = [string componentsSeparatedByString:@"&"];
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:[array count]];
    
    for (NSString* keyValue in array)
    {
        NSRange range = [keyValue rangeOfString:@"="];
        if (range.location == NSNotFound)
        {
            [dict setValue:@"" forKey:keyValue];
        }
        else
        {
            NSString* key = [keyValue substringToIndex:range.location];
            NSString* value = [keyValue substringFromIndex:range.location + range.length];
            [dict setValue:[value URLDecodedString] forKey:key];
        }
    }
    return dict;
}


+ (NSString*)  urlArgsStringFromDictionary:(NSDictionary*)dict
{
    NSMutableArray* keyValues = [NSMutableArray arrayWithCapacity:[dict count]];
    for (NSString* key in dict)
    {
        NSString* value = [dict objectForKey:key];
        NSString* keyValue = [NSString stringWithFormat:@"%@=%@", key, [value URLEncodedString]];
        [keyValues addObject:keyValue];
    }
    return [keyValues componentsJoinedByString:@"&"];
}

@end