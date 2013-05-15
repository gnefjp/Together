//
//  CommonTool.h
//  Together
//
//  Created by Gnef_jp on 13-5-10.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonTool : NSObject

+ (CommonTool *) shareTool;

@end


#pragma mark- Extend

#pragma mark- UIImageView
@interface UIImageView (CommonTool)

- (void) setImageWithFileID:(NSString *)imageID
           placeholderImage:(UIImage *)placeholderImage;

@end