//
//  FileManager.h
//  WowPlus
//
//  Created by ZengRuihui on 14-8-28.
//
//

#import <Foundation/Foundation.h>

#define NOTIF_FILE_DOWNLOAD_SUCCESS @"NOTIF_FILE_DOWNLOAD_SUCCESS" //下载成功
#define NOTIF_FILE_DOWNLOAD_FAILURE @"NOTIF_FILE_DOWNLOAD_FAILURE" //下载失败
#define NOTIF_FILE_DOWNLOADING @"NOTIF_FILE_DOWNLOADING" //下载过程

#define FILE_MANAGER [FileManager sharedInstance]

@interface FileManager : NSObject

+ (FileManager *)sharedInstance;
+ (void)destroyInstance;

//如果文件存在 则返回文件路径 否则开始下载
- (NSString *)startDownloadFileWithUrl:(NSString *)fileUrl;

//删除文件
+ (void)removeFile:(NSString *)filePath;
//文件是否存在
+ (BOOL)fileExistsAtPath:(NSString *)filePath;
+ (void)createDir:(NSString *)filePath;
//文件大小
+ (long long)fileSizeAtPath:(NSString*)filePath;
//取图片缓存文件夹路径
+ (NSString *)getImageCacheDirPath;
//取得url对应文件所在的路径 (本地路径则返回本身)
+ (NSString *)getFilePathWithUrl:(NSString *)fileUrl;

@end
