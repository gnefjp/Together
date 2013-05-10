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


- (NSDate *) stringToDateWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:self];
}

@end