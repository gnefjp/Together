//
//  ChangeAvatar.m
//  Together
//
//  Created by APPLE on 13-4-23.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "ChangeAvatar.h"

@implementation ChangeAvatar

@synthesize delegate = _delegate;

- (void) addAvataActionSheet
{
    [AvataActioSheet showWithDelegate:self];
}

- (void)SysPhotoBtnDidPressed
{
    

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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"无法打开本地图片" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
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
        
    }
}



@end
