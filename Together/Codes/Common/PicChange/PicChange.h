//
//  ChangeAvatar.h
//  Together
//
//  Created by APPLE on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PicActioSheet.h"
#import "PicCutView.h"



@class PicChange;

@protocol PicChangeDelegate <NSObject>

- (void)PicChangeSuccess:(PicChange*)v img:(UIImage*)img;

@end

@interface PicChange : NSObject<PicActioSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PicCutViewDelegate>
{
    __weak id<PicChangeDelegate>     _delegate;
    cutType                          _eType;
}

@property (weak,nonatomic) id<PicChangeDelegate>     delegate;
@property (nonatomic)       cutType                  eType;

- (void)addAvataActionSheet;

@end
