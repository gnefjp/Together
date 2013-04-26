//
//  GEMTUserInfo.h
//  Together
//
//  Created by APPLE on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GEMTUserInfo : NSObject
{
    NSString             *_userName;
    NSString             *_passWord;
}

@property (strong, nonatomic) NSString             *userName;
@property (strong, nonatomic) NSString             *passWord;


@end
