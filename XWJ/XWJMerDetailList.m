//
//  XWJMerDetailList.m
//  XWJ
//
//  Created by Sun on 15/12/24.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJMerDetailList.h"
#define PADDINGTOP 64.0
#define BTN_WIDTH 100.0
#define BTN_HEIGHT 50.0
@interface XWJMerDetailList()
@property NSMutableArray *btn;
@property UIView * typeContainView;
@property UIView *adView;
@property UIScrollView *scroll;
@property UITableView *tableView;

@end
@implementation XWJMerDetailList

@synthesize scroll;
-(void)viewDidLoad{
    
    [super viewDidLoad];
//    self.thumbArr = [NSMutableArray array];
//    self.adArr = [NSMutableArray array];
//    tabledata = [NSMutableArray array];
//    [self getShuoMore];
    
//        _adView =[[UIView alloc] initWithFrame:CGRectMake(0, PADDINGTOP, SCREEN_SIZE.width, SCREEN_SIZE.height/4)];
    scroll  =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    [self.view addSubview:scroll];
    scroll.contentSize = CGSizeMake(SCREEN_SIZE.width, SCREEN_SIZE.height+100);
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    [self addView];
}

-(void)addView{
    self.adView =[[UIView alloc] initWithFrame:CGRectMake(0, PADDINGTOP, SCREEN_SIZE.width, SCREEN_SIZE.height/5)];
    
    self.btn = [NSMutableArray array];
    NSInteger count = 3;
    CGFloat width = self.view.bounds.size.width/3;
    CGFloat height = 60;
    CGFloat btny = self.adView.frame.origin.y+self.adView.bounds.size.height+10;
    NSArray * title = [NSArray arrayWithObjects:@"最新",@"销量",@"价格", nil];
    for (int i=0; i<count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(width*i, btny, width, height);
        button.tag = i;
        
        [button setTitle:[title objectAtIndex:i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"shuoselect"] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"shuonormal"] forState:UIControlStateNormal];
        
        [button setTitleColor:XWJColor(77, 78, 79) forState:UIControlStateNormal];
        [button setTitleColor:XWJGREENCOLOR forState:UIControlStateSelected];
        
        //        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        ////        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        //        [button setImageEdgeInsets:UIEdgeInsetsMake(5, 20, 0, 0)];
        //        [button setTitleEdgeInsets:UIEdgeInsetsMake(45, -25, 0, 0)];
        //        button.backgroundColor = [UIColor whiteColor];
        
        [button addTarget:self action:@selector(typeclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btn addObject:button];
        [scroll addSubview:button];
    }
    ((UIButton*)self.btn[0]).selected=YES;
    _typeContainView = [[UIView alloc] initWithFrame:CGRectMake(0, btny+60, SCREEN_SIZE.width, SCREEN_SIZE.height-btny)];
    //    _typeContainView.backgroundColor = [UIColor redColor];
    [scroll addSubview:_typeContainView];
    [scroll addSubview:self.adView];
}
-(void)typeclick:(UIButton *)butn{
    NSInteger index = butn.tag;
    for (UIButton *b in self.btn) {
        b.selected = NO;
    }
    butn.selected = !butn.selected;
}
@end
