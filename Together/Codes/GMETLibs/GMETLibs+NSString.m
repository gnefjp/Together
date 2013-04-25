//
//  GMETLibs+NSString.m
//  Together
//
//  Created by Gnef_jp on 13-4-25.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GMETLibs+NSString.h"


@implementation NSString (GMETLibs)

- (NSString*) timestampToDateUsingFormat:(NSString*)format
{
    double timestamp = [self doubleValue];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

@end