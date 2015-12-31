//
//  PhotoSelectManager.m
//  Housekeeping
//
//  Created by ZengRuihui on 15/6/30.
//  Copyright (c) 2015年 窗外`. All rights reserved.
//

#import "PhotoSelectManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "FileManager.h"

static PhotoSelectManager *instance = nil;

@interface PhotoSelectManager () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    
}

@property (nonatomic, strong) void (^selectedBlock)(FileModel *);//照片选择回调

@end

@implementation PhotoSelectManager

+ (PhotoSelectManager *)sharedInstance
{
    if(instance == nil) {
        instance = [[PhotoSelectManager alloc] init];
    }
    return instance;
}

+ (void)destroyInstance
{
    instance = nil;
}

- (void)showSelectPhotoView:(void (^)(FileModel *data))selectedBlock
{
    self.selectedBlock = selectedBlock;
    
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"选择照片", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"摄像头", nil), NSLocalizedString(@"相册", nil), nil];
    [as showInView:m_appDelegate.window];
}


#pragma mark    - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //摄像头
        if ([self hasCameraAuthorized]) {
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing = NO;
            [m_appDelegate.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
            return;
        }
    }
    else if (buttonIndex == 1) {
        //相册
        if ([self hasAlbumAuthorized]) {
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.allowsEditing = NO;
            [m_appDelegate.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
            return;
        }
    }
    self.selectedBlock = nil;
}


#pragma mark    - UIImagePickerControllerDelegate UINavigationControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [m_appDelegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];

    CGSize screenSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT * 2);
    CGSize scaleSize = CGSizeZero;
    if (image.size.width <= screenSize.width && image.size.height <= screenSize.height) {
        scaleSize = image.size;
    }
    else {
        CGFloat widthFactor = screenSize.width / image.size.width;
        CGFloat heightFactor = screenSize.height / image.size.height;
        CGFloat scaleFactor = 0.0;
        if (widthFactor <= heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaleSize = CGSizeMake(image.size.width * scaleFactor, image.size.height * scaleFactor);
    }

    NSString *fileName = [[ShareFunction uuid] stringByAppendingString:@".png"];
    NSString *path = [FileManager getImageCacheDirPath];
    NSString *imagePath = [path stringByAppendingFormat:@"/%@", fileName];
    NSString *thumbImagePath = [path stringByAppendingFormat:@"/thumb_%@", fileName];
    [image createThumbImageWithSize:scaleSize percent:0.4 toPath:imagePath];

    [image createThumbImageWithSize:CGSizeMake(270, 270) percent:0.6 toPath:thumbImagePath];

    NSData *data = [NSData dataWithContentsOfFile:thumbImagePath];
    UIImage *thumbImage = [UIImage imageWithData:data scale:3];

    FileModel *model = [[FileModel alloc] init];
    model.type = FileType_Photo;
    model.path = imagePath;
    model.thumbImage = thumbImage;

    if (self.selectedBlock) {
        self.selectedBlock(model);
        self.selectedBlock = nil;
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.selectedBlock = nil;
    [m_appDelegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


#pragma mark    - 取权限

//取摄像头权限
- (BOOL)hasCameraAuthorized
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if (SYSTEM_VERSION >= 7.0) {
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (AVAuthorizationStatusDenied == authStatus) {
                //拒绝
                if (SYSTEM_VERSION >= 8.0) {//请在系统设置中开启相机权限
                    UIAlertView* alert =[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"开启相机权限", nil) message:NSLocalizedString(@"请在系统设置中开启相机权限", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:NSLocalizedString(@"开启权限", nil), nil];
                    alert.tag = 99;
                    [alert show];
                }
                else {
                    UIAlertView* alert =[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"开启相机权限", nil) message:NSLocalizedString(@"请在系统设置中开启相机权限", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                    [alert show];
                }
                return NO;
            }
        }
    }
    else {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"该设备不支持照相功能", nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    return YES;
}

//取相册权限
- (BOOL)hasAlbumAuthorized
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        if (SYSTEM_VERSION >= 7.0) {
            ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
            if (AVAuthorizationStatusDenied == authStatus) {
                //拒绝
                if (SYSTEM_VERSION >= 8.0) {
                    UIAlertView* alert =[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"开启相册权限", nil) message:NSLocalizedString(@"请在系统设置中开启相册权限", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:NSLocalizedString(@"开启权限", nil), nil];
                    alert.tag = 99;
                    [alert show];
                }
                else {
                    UIAlertView* alert =[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"开启相册权限", nil) message:NSLocalizedString(@"请在系统设置中开启相册权限", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                    [alert show];
                }
                return NO;
            }
        }
    }
    else {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"该设备不支持相册功能", nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 99) {
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
        }
    }
}

@end

@implementation FileModel
@end