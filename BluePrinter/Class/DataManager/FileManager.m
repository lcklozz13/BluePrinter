//
//  FileManager.m
//  WowPlus
//
//  Created by ZengRuihui on 14-8-28.
//
//

#import "FileManager.h"
#import "ASIHTTPRequest.h"
//#import "NSData+Base64.h"
#import "NSString+MKNetworkKitAdditions.h"

#include <sys/stat.h>

static FileManager *instance = nil;

@interface FileManager ()
{
    NSOperationQueue *_oqRequestQueue;
}
@end

@implementation FileManager

+ (FileManager *)sharedInstance
{
	if(instance == nil)
    {
		instance = [[FileManager alloc] init];
    }
	return instance;
}

+ (void)destroyInstance
{
    instance = nil;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _oqRequestQueue = [[NSOperationQueue alloc] init];
        _oqRequestQueue.maxConcurrentOperationCount = 2;
    }
    return self;
}

- (void)dealloc
{
    NSArray *array = [_oqRequestQueue operations];
    for (ASIHTTPRequest *request in array) {
        [request clearDelegatesAndCancel];
    }
}


#pragma mark    - 下载

//如果文件存在 则返回文件路径 否则开始下载
- (NSString *)startDownloadFileWithUrl:(NSString *)fileUrl
{
    //排除重复的下载
    NSArray *array = [_oqRequestQueue operations];
    for (ASIHTTPRequest *request in array) {
        NSString *url = [request.url absoluteString];
        if ([url isEqualToString:fileUrl])
            return nil;
    }

    NSString *filePath = [FileManager getFilePathWithUrl:fileUrl];
    if ([FileManager fileExistsAtPath:filePath]) {
        return filePath;
    }
    NSString *url = fileUrl;
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setDownloadDestinationPath:filePath];
    [request setTemporaryFileDownloadPath:[filePath stringByAppendingString:@".temp"]];
    [request setAllowResumeForFileDownloads:YES];
    [request setDownloadProgressDelegate:self];
    [request setShowAccurateProgress:YES];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(downloadFileFailure:)];
    [request setDidFinishSelector:@selector(downloadFileFinish:)];
    [request setTimeOutSeconds:60];
    [request setValidatesSecureCertificate:NO];
    request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:filePath, @"path", fileUrl, @"originalUrl", nil];
    NSLog(@"开始下载：%@", url);
    [_oqRequestQueue addOperation:request];
    
    return nil;
}


#pragma mark    - 下载委托

//下载结束
- (void)downloadFileFinish:(ASIHTTPRequest *)request
{
    if (request.responseStatusCode != 200) {
        NSLog(@"%@  %@", request.responseStatusMessage, request.url);
        return;
    }
    
    NSString *path = [request.userInfo objectForKey:@"path"];
    NSString *url = [request.userInfo objectForKey:@"originalUrl"];
    NSDictionary *dic = @{@"path": path, @"url": url};
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_FILE_DOWNLOAD_SUCCESS object:dic];
    NSLog(@"下载成功：%@", url);
}

//下载失败
- (void)downloadFileFailure:(ASIHTTPRequest *)request
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_FILE_DOWNLOAD_FAILURE object:[request.url absoluteString]];
    NSLog(@"下载失败：%@", request.url);
}


#pragma mark    - 常用

//删除文件
+ (void)removeFile:(NSString *)filePath
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL bRet = [fileMgr fileExistsAtPath:filePath];
    if (bRet) {
        NSError *err;
        [fileMgr removeItemAtPath:filePath error:&err];
    }
}

//文件是否存在
+ (BOOL)fileExistsAtPath:(NSString *)filePath
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL bRet = [fileMgr fileExistsAtPath:filePath];
    return bRet;
}

+ (void)createDir:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    if (!(isDir == YES && existed == YES))
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
}

//文件大小
+ (long long)fileSizeAtPath:(NSString*)filePath
{
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    
    return 0;
}

//取图片缓存文件夹路径
+ (NSString *)getImageCacheDirPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    return cachePath;
}

//取得url对应文件所在的路径 (本地路径则返回本身)
+ (NSString *)getFilePathWithUrl:(NSString *)fileUrl
{
    NSString *cachePath = [FileManager getImageCacheDirPath];
    NSString *filename = [[fileUrl pathComponents] lastObject];
    if ([fileUrl hasPrefix:@"http"]) {
        filename = [fileUrl md5];
        NSString *path = [cachePath stringByAppendingFormat:@"/%@", filename];
        return path;
    }
    return @"";
}

@end
