//
//  SQLiteManager.m
//  TuanXin
//
//  Created by 窗外` on 13-12-16.
//  Copyright (c) 2013年 窗外`. All rights reserved.
//

#import "SQLiteManager.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

//购物车数据表 有字段变动时 后面的数字加1
#define TABLENAME_SHOPCART_DATA @"TABLENAME_SHOPCART_DATA_1"

static SQLiteManager *instance;

@interface SQLiteManager ()
{
    sqlite3 *m_db;
    NSString *mDBPath;
    FMDatabaseQueue *m_dbQueue;
}
@end

@implementation SQLiteManager

+ (SQLiteManager *)sharedInstance
{
    if (!instance) {
        instance = [[SQLiteManager alloc] init];
    }
    [instance initDatabase];

    return instance;
}

+ (void)destroyInstance
{
    [instance closeDB];
    instance = nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        m_dbQueue = nil;
    } 

    return self;
}

- (void)closeDB
{
    if(m_dbQueue) {
        [m_dbQueue close];
        m_dbQueue = nil;
    }
}

- (void)initDatabase
{
    if(!DATA_MANAGER.isLogin)
        return;
    if(m_dbQueue)
        //已初始化过
        return;
    
    NSString *userId = DATA_MANAGER.userInfo.uid;
    NSString *documents = [FileManager getImageCacheDirPath];
    int version = 1;//当数据库有字段增加时 版本号+1
    NSString *database_path = [documents stringByAppendingPathComponent:[NSString stringWithFormat:@"Base_%@_v%d.sqlite", userId, version]];
    
    mDBPath = [[NSString alloc] initWithString:database_path];
    m_dbQueue = [FMDatabaseQueue databaseQueueWithPath:mDBPath];
    
    [m_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql1 = [NSString stringWithFormat:@"create table if not exists %@ (id, name, photo, price, productId, mainType, subType, count, stock)", TABLENAME_SHOPCART_DATA];
        [db executeUpdate:sql1];
    }];
}


#pragma mark    - 购物车

//加入购物车
- (void)addCartInfo:(CartModel *)model
{
    if(!m_dbQueue)
        return;
    
    if (model.count == 0) {
        //删除
        [self deleteCartWithId:model.id];
    }
    else {
        __block int count = 0;
        [m_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            NSString *sql = [NSString stringWithFormat:@"select count from %@ where id = '%@'", TABLENAME_SHOPCART_DATA, model.id];
            FMResultSet *rs = [db executeQuery:sql];
            while ([rs next]) {
                count = [[[rs resultDictionary] objectForKey:@"count"] intValue];
                break;
            }
            [rs close];
        }];

        
        if (count > 0) {
            //更新
            model.count += count;
            [self updateCartInfo:model];
        }
        else {
            //添加
            [m_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
                NSString *sql = [NSString stringWithFormat:@"insert into %@ (id, name, photo, price, productId, mainType, subType, count, stock) values ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%d', '%d')", TABLENAME_SHOPCART_DATA, model.id, model.name, model.photo, model.price, model.productId, model.mainType, model.subType, model.count, model.stock];
                [db executeUpdate:sql];
            }];
        }
    }
}

//更新购物车
- (void)updateCartInfo:(CartModel*)model
{
    if(!m_dbQueue)
        return ;

    [m_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = [NSString stringWithFormat:@"update %@ set count = '%d', stock = '%d', photo = '%@', subType = '%@' where id = '%@'", TABLENAME_SHOPCART_DATA, model.count, model.stock, model.photo, model.subType, model.id];
        [db executeUpdate:sql];
    }];
}

//查询购物车列表
- (NSArray *)queryCartList
{
    if(!m_dbQueue)
        return nil;
    
    __block NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [m_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@ ", TABLENAME_SHOPCART_DATA]];
        while ([rs next]) {
            CartModel* model = [[CartModel alloc] initWithData:[rs resultDictionary]];
            NSMutableArray *list = [data valueForKey:model.mainType];
            if (!list) {
                list = [NSMutableArray array];
                [data setValue:list forKey:model.mainType];
            }
            [list addObject:model];
        }
        [rs close];
    }];
    
    NSMutableArray *list = [NSMutableArray array];
    for (NSString *key in data.allKeys) {
        id object = [data objectForKey:key];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:key forKey:@"type"];
        [dic setValue:object forKey:@"list"];
        [list addObject:dic];
    }
    
    return list;
}

//删除购物车商品
- (void)deleteCartWithId:(NSString *)wid
{
    if(!m_dbQueue)
        return;
    [m_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:[NSString stringWithFormat:@"delete from %@ where id = '%@'", TABLENAME_SHOPCART_DATA, wid]];
    }];
}

@end
