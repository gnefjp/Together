//
//  ChangeAvatar.h
//  Together
//
//  Created by APPLE on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PicActioSheet.h"

@class PicChange;

@protocol PicChangeDelegate <NSObject>

- (void)PicChangeSuccess:(PicChange*)self img:(UIImage*)img;

@end

@interface PicChange : NSObject<PicActioSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    __weak id<PicChangeDelegate>     _delegate;
    
}

@property (weak,nonatomic) id<PicChangeDelegate>     delegate;

- (void)addAvataActionSheet;

@end
