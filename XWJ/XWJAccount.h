//
//  XWJAccount.h
//  XWJ
//
//  Created by Sun on 15/12/7.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWJAccount : NSObject

@property NSString *uid;
@property NSString *account;
@property NSString *password;
@property NSString *NickName;
@property NSString *phone;
@property NSString *name;
@property NSString *Sex;
@property NSString *jifen;
@property NSString *money;
@property NSString *ganqing;
@property NSString *intrest;
@property NSString *qianming;
+ (instancetype) instance ;
/*
 
 {"result":"1","data":{"area":[],"user":{"id":15,"Account":"18563938903","Types":null,"NAME":null,"NickName":null,"TEL":null,"R_id":"","U_id":null,"AccountCount":0,"LastLoginTime":null,"LastLoginIP":null,"RegisterTime":"2015-12-07","RegisterIP":"192.168.0.123","PhoneType":"MI 3C","sex":null,"Photo":null,"gxqm":null,"DictValue":null}},"errorCode":"登录成功！"}
 */
- (void)loginSuccess:(void (^)(NSData *))success
             failure:(void (^)(NSError *error))failure;
@end
