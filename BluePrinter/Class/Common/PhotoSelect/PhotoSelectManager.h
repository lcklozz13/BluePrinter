//
//  PhotoSelectManager.h
//  Housekeeping
//
//  Created by ZengRuihui on 15/6/30.
//  Copyright (c) 2015年 窗外`. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZBaseModel.h"

#define PHOTO_MANAGER [PhotoSelectManager sharedInstance]

typedef enum : NSUInteger {
    FileType_Photo = 0,
    FileType_Video = 1,
    FileType_Audio = 2,
} FileType;

@interface FileModel : WZBaseModel

@property (assign, nonatomic) FileType type;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) id thumbImage;
@property (strong, nonatomic) NSString *thumbImagePath;
@property (strong, nonatomic) NSString *thumbImageUrl;
@property (strong, nonatomic) id data;
@property (assign, nonatomic) NSInteger audioDuration;

@end

@interface PhotoSelectManager : NSObject

+ (PhotoSelectManager *)sharedInstance;
+ (void)destroyInstance;

- (void)showSelectPhotoView:(void (^)(FileModel *data))selectedBlock;

@end
