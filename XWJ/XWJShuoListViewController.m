//
//  XWJShuoListViewController.m
//  XWJ
//
//  Created by Sun on 15/12/21.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJShuoListViewController.h"

@interface XWJShuoListViewController()
@property UIView *adView;
@property NSMutableArray *data;
@property UIView * typeContainView;

@end
#define PADDINGTOP 64.0
#define BTN_WIDTH 100.0
#define BTN_HEIGHT 45.0

@implementation XWJShuoListViewController
@synthesize adView,data,type,typeContainView;
-(void)viewDidLoad{

    [super viewDidLoad];
    [self addView];
}

-(void)addView{
    adView =[[UIView alloc] initWithFrame:CGRectMake(0, PADDINGTOP, SCREEN_SIZE.width, SCREEN_SIZE.height/4)];
 
    for (int i =0; i<data.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, i*BTN_HEIGHT, BTN_WIDTH, BTN_HEIGHT);
    }
}

@end
