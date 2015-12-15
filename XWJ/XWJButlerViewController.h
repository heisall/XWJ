//
//  XWJButlerViewController.h
//  信我家
//
//  Created by Sun on 15/11/28.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJBaseViewController.h"
#import "LCBannerView.h"
@interface XWJButlerViewController : XWJBaseViewController<LCBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *bnt2;
@property (weak, nonatomic) IBOutlet UIButton *bnt3;
@property (weak, nonatomic) IBOutlet UIButton *bnt;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIButton *bt6;

@property (weak, nonatomic) IBOutlet UIButton *bnt4;

@property (weak, nonatomic) IBOutlet UIButton *bnt5;

@property NSMutableArray *notices;
@property NSMutableArray *shows ;
@end
