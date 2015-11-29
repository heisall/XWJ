//
//  XWJMineViewController.m
//  信我家
//
//  Created by Sun on 15/11/28.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJMineViewController.h"

@implementation XWJMineViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"我的";
    self.navigationItem.leftBarButtonItem = nil;
}

@end
