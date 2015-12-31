//
//  SQLiteManager.h
//  TuanXin
//
//  Created by 窗外` on 13-12-16.
//  Copyright (c) 2013年 窗外`. All rights reserved.
//

#import <Foundation/Foundation.h>


#define SQLITE_MANAGER [SQLiteManager sharedInstance]

@interface SQLiteManager : NSObject

+ (SQLiteManager *)sharedInstance;
+ (void)destroyInstance;

- (void)initDatabase;
- (void)closeDB;


#pragma mark    - 购物车

//加入购物车
- (void)addCartInfo:(CartModel *)model;

//更新购物车
- (void)updateCartInfo:(CartModel*)model;

//查询购物车列表
- (NSArray *)queryCartList;

//删除购物车商品
- (void)deleteCartWithId:(NSString *)wid;

@end
