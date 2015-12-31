//
//  NSData+Base64.m
//  Gurpartap Singh
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Base64Additions)

+ (NSData *)base64DataFromString:(NSString *)string;
+ (id)dataWithBase64EncodedString:(NSString *)string;     //  Padding '=' characters are optional. Whitespace is ignored.
- (NSString *)base64Encoding;

@end