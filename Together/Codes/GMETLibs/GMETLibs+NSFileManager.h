//
//  GMETLibs+NSFileManager.h
//  Together
//
//  Created by Gnef_jp on 13-5-9.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager(GMETLibs)

// 应用程序文档目录
+ (NSString*) documentPath;


// 资源目录
+ (NSString*) resourcePath;


// caches目录
+ (NSString*) cachesPath;


// 临时目录
+ (NSString*) temporaryPath;


// 如果filePath目录不存在, 就创建此目录, 失败返回FALSE
// 比如路径为　/Hello/Hi/OK/World, 如果当前之后路径　/Hello,
// 就会连续创建目录　Hi, OK, World, 使得/Hello/Hi/OK/World存在
+ (BOOL) letDirectoryExistsAtPath:(NSString*)filePath;

@end
