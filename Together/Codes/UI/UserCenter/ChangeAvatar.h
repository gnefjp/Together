//
//  ChangeAvatar.h
//  Together
//
//  Created by APPLE on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AvataActioSheet.h"

@protocol ChangeAvatarDelegate <NSObject>

- (void)ChangeAvatarSelectImage:(UIImage*)img;

@end

@interface ChangeAvatar : NSObject<AvataActioSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    __weak id<ChangeAvatarDelegate>     _delegate;
    
}

@property (nonatomic,weak) id<ChangeAvatarDelegate>     delegate;

- (void)addAvataActionSheet;

@end
