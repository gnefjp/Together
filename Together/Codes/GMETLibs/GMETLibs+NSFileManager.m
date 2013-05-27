//
//  GMETLibs+NSFileManager.m
//  Together
//
//  Created by Gnef_jp on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GMETLibs+NSFileManager.h"

@implementation NSFileManager(GMETLibs)

+ (NSString*) documentPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}



+ (NSString*) resourcePath
{
	return [[NSBundle mainBundle] resourcePath];
}


+ (NSString*) cachesPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}


+ (NSString*) temporaryPath
{
    return NSTemporaryDirectory();
}



+ (BOOL) letDirectoryExistsAtPath:(NSString*)filePath
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:filePath])
	{
		return YES;
	}
    
	NSArray* array = [filePath componentsSeparatedByString:@"/"];
    NSString* oldCurrentDir = [fileManager currentDirectoryPath];
    
    if ([filePath hasPrefix:@"/"])
    {
        [fileManager changeCurrentDirectoryPath:@"/"];
    }
	
	for (NSString* string in array)
	{
		if ([string length] > 0)
		{
			BOOL isDirectory = TRUE;
			if (![fileManager fileExistsAtPath:string isDirectory:&isDirectory] ||
				!isDirectory)
			{
				[fileManager createDirectoryAtPath:string
                       withIntermediateDirectories:YES
                                        attributes:nil
                                             error:nil];
			}
			[fileManager changeCurrentDirectoryPath:string];
		}
	}
    
    [fileManager changeCurrentDirectoryPath:oldCurrentDir];
	return [fileManager fileExistsAtPath:filePath];
}

@end
