//
//  BPFileManager.m
//  BluePrinter
//
//  Created by baidu on 15/11/9.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "BPFileManager.h"
#import "UIImageView+WebCache.h"

@implementation BPFileManager

+ (float)fileSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:path])
    {
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    
    return 0;
}

+ (float)folderSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float folderSize;
    
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles)
        {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize += [BPFileManager fileSizeAtPath:absolutePath];
        }
        
        folderSize += [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    
    return 0;
}

+(void)clearCache:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles)
        {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}
@end
