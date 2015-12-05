//
//  XWJActivityViewController.m
//  XWJ
//
//  Created by Sun on 15/12/5.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJActivityViewController.h"

@implementation XWJActivityViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.webView loadRequest:request];
}

- (IBAction)enroll:(UIButton *)sender {
    NSLog(@"baoming");
}

@end
