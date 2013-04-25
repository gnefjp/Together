//
//  ChangeAvatar.h
//  Together
//
//  Created by APPLE on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PicActioSheet.h"

@protocol ChangeAvatarDelegate <NSObject>

- (void)ChangeAvatarSelectImage:(UIImage*)img;

@end

@interface PicChange : NSObject<PicActioSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    __weak id<ChangeAvatarDelegate>     _delegate;
    
}

@property (weak,nonatomic) id<ChangeAvatarDelegate>     delegate;

- (void)addAvataActionSheet;

@end
