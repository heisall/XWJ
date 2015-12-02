//
//  XWJLifeViewController.h
//  信我家
//
//  Created by Sun on 15/11/28.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJBaseViewController.h"
#import "LCBannerView.h"
@interface XWJLifeViewController : XWJBaseViewController<LCBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *adScrollView;

@end
