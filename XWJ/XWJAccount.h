//
//  XWJAccount.h
//  XWJ
//
//  Created by Sun on 15/12/7.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWJAccount : NSObject

@property NSString *uname;
@property NSString *password;

- (void)loginSuccess:(void (^)(NSData *))success
             failure:(void (^)(NSError *error))failure;
@end
