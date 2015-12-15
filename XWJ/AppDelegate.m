//
//  AppDelegate.m
//  信我家
//
//  Created by Paul on 9/11/15.
//  Copyright (c) 2015年 Paul. All rights reserved.
//

#import "AppDelegate.h"
#import "XWJdef.h"
#import "AFNetworking.h"
#import <SMS_SDK/SMSSDK.h>
#import "XWJCity.h"
#define mobAppKey @"c647ba762dc0"
#define mobAppSecret @"76e6d7422f5d958e9a882675d0ffbd29"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [SMSSDK registerApp:mobAppKey withSecret:mobAppSecret];
    
    
//    __strong NSMutableArray *arr = [NSMutableArray array];

//    [self getCity];
//
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    

    if (![self checkAutoLogin]) {
        UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"XWJLoginStoryboard" bundle:nil];
        self.window.rootViewController = [loginStoryboard instantiateInitialViewController];

    }else{
        ;
    }
    
//    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"XWJLoginStoryboard" bundle:nil];
//    self.window.rootViewController = [loginStoryboard instantiateViewControllerWithIdentifier:@"bindhouse2"];
    
    
    return YES;
}

-(void)getCity{
    
    NSString *url = GETCITY_URL;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    [dict setValue:username forKey:@"account"];
    //    [dict setValue:pwd forKey:@"password"];
    
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%s success ",__FUNCTION__);
        
        if(responseObject){
            NSDictionary *dic = (NSDictionary *)responseObject;
            
//            NSMutableArray * array = [NSMutableArray array];
//            XWJCity *city  = [[XWJCity alloc] init];
            
            NSArray *arr  = [dic objectForKey:@"data"];
            for (NSDictionary *d in arr) {
                NSLog(@"dic %@",d);
            }
            
            
            NSLog(@"dic %@",dic);
        }
        //        XWJTabViewController *tab = [[XWJTabViewController alloc] init];
        //        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        //        window.rootViewController = tab;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%s fail ",__FUNCTION__);
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //        XWJTabViewController *tab = [[XWJTabViewController alloc] init];
        //        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        //        window.rootViewController = tab;            //        });
    }];
}

-(BOOL)checkAutoLogin{

    return FALSE;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
