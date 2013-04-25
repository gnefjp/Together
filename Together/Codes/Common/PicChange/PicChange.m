//
//  ChangeAvatar.m
//  Together
//
//  Created by APPLE on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "PicChange.h"

@implementation PicChange

@synthesize delegate = _delegate;

- (void) addAvataActionSheet
{
    [PicActioSheet showWithDelegate:self];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissModalViewControllerAnimated:YES];
    [_delegate ChangeAvatarSelectImage:image];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
     [picker dismissModalViewControllerAnimated:YES];
}

- (void)picActioSheet:(PicActioSheet *)p picType:(ePicActioSheetType)eType
{
    switch (eType) {
        case ePicActioSheetType_SysPhoto:
        {
            [self SysPhotoBtnDidPressed];
            break;
        }
        case ePicActioSheetType_LocalPhoto:
        {
            [self LocalPhotoBtnDidPressed];
            break;
        }
        case ePicActioSheetType_TakePhoto:
        {
            [self TakePhotoBtnDidPressed];
            break;
        }
        default:
            break;
    }
}

- (void)SysPhotoBtnDidPressed
{
    
}

- (void)LocalPhotoBtnDidPressed
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [[UIView rootController] presentModalViewController:picker animated:YES];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"无法打开本地图片" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [[UIView rootView] addSubview:alert];
        [alert show];
    }
}

- (void)TakePhotoBtnDidPressed
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [[UIView rootController] presentModalViewController:picker animated:YES];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没相机使用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [[UIView rootView] addSubview:alert];
        [alert show];
    }
}



@end
