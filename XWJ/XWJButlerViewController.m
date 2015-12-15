//
//  XWJButlerViewController.m
//  信我家
//
//  Created by Sun on 15/11/28.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJButlerViewController.h"
#import "XWJButlerViewController.h"
#import "LCBannerView.h"
#import "XWJNoticeViewController.h"
#import "XWJGuzhangViewController.h"
#import "AFNetworking.h"
#import "XWJCity.h"
#import "XWJPay1ViewController.h"
#import "XWJZFViewController.h"
@implementation XWJButlerViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initData];
}

-(void)addView{
    for (int i=0; i<7; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"guanjia%d",i+1]] forState:UIControlStateNormal];
        btn.frame = CGRectMake((SCREEN_SIZE.width/4+1)*(i%4), self.room.frame.origin.y+self.room.bounds.size.height+60 + ((int)(i/4))*(SCREEN_SIZE.width/4+1), SCREEN_SIZE.width/4 , SCREEN_SIZE.width/4 );
        btn.tag = i;
        btn.backgroundColor = XWJColor(124, 197, 193);
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

-(void)initData{
    self.titles = [NSArray arrayWithObjects:@"物业通知",@"社区活动",@"物业监督",@"故障报修",@"物业投诉", @"物业账单",nil];

    
    UIStoryboard * HomeStoryboard = [UIStoryboard storyboardWithName:@"HomeStoryboard" bundle:nil];
    XWJNoticeViewController *notice = [HomeStoryboard instantiateViewControllerWithIdentifier:@"noticeController"];
    notice.type  = @"0";
    XWJNoticeViewController *notice2 = [HomeStoryboard instantiateViewControllerWithIdentifier:@"noticeController"];
    notice2.type  = @"1";
    
    
    UIStoryboard * wuy = [UIStoryboard storyboardWithName:@"WuyeStoryboard" bundle:nil];
    UIViewController *wu = [wuy instantiateInitialViewController];
    
    XWJPay1ViewController *pay = [HomeStoryboard instantiateViewControllerWithIdentifier:@"pay1"];
    
    UIStoryboard *guzhang = [UIStoryboard storyboardWithName:@"GuzhanStoryboard" bundle:nil];
    XWJGuzhangViewController *gz = [guzhang instantiateInitialViewController];
    
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"XWJZFStoryboard" bundle:nil];

    XWJZFViewController *zf = [story instantiateInitialViewController];
    zf.type = 2;
    
    self.vConlers = [NSArray arrayWithObjects:notice,notice2,wu,gz,notice,pay,zf,nil];
}

-(void)btnclick:(UIButton *)btn{
    [self.navigationController showViewController:[self.vConlers objectAtIndex:btn.tag] sender:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"管家";
    self.navigationItem.leftBarButtonItem = nil;

    NSString *ti =[NSString stringWithFormat:@"%@%@",[[XWJCity instance].district valueForKey:@"a_name"]?[[XWJCity instance].district valueForKey:@"a_name"]:@"",[[XWJCity instance].buiding valueForKey:@"b_name"]?[[XWJCity instance].buiding valueForKey:@"b_name"]:@""];
    self.room.text  = ti;
    [self addView];

    [self getAd];
    
//    /******************** internet ********************/
//    NSArray *URLs = @[@"http://admin.guoluke.com:80/userfiles/files/admin/201509181707000766.png",
//                      @"http://admin.guoluke.com:80/userfiles/files/admin/201509181707000766.png",
//                      @"http://img.guoluke.com/upload/201509091054250274.jpg"];
//    [self.adView addSubview:({
//        
//        LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
//                                                                                self.adView.bounds.size.height)
//                                    
//                                                            delegate:self
//                                                           imageURLs:URLs
//                                                    placeholderImage:nil
//                                                       timerInterval:3.0f
//                                       currentPageIndicatorTintColor:[UIColor redColor]
//                                              pageIndicatorTintColor:[UIColor whiteColor]];
//        bannerView;
//    })];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
}

-(void)getAd{
    NSString *url = GETAD_URL;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    [dict setValue:[XWJCity instance].aid  forKey:@"a_id"];
    [dict setValue:@"1"  forKey:@"a_id"];
    
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%s success ",__FUNCTION__);
        
        if(responseObject){
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSLog(@"dic %@",dic);
            
            self.notices = [dic objectForKey:@"notices"];
            self.shows = [dic objectForKey:@"topad"];
            
            NSMutableArray *titls = [NSMutableArray array];
            for (NSDictionary *dic in self.notices) {
                [titls addObject:[dic valueForKey:@"title"]];
            }
            
            NSMutableArray *URLs = [NSMutableArray array];
            for (NSDictionary
                 *dic in self.shows) {
                [URLs addObject:[dic valueForKey:@"Photo"]];
                
            }
            
            if(URLs&&URLs.count>0)
                [self.adView addSubview:({
                    
                    LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                                                                            self.adView.bounds.size.height)
                                                
                                                                        delegate:self
                                                                       imageURLs:URLs
                                                                placeholderImage:@"devAdv_default"
                                                                   timerInterval:3.0f
                                                   currentPageIndicatorTintColor:[UIColor redColor]
                                                          pageIndicatorTintColor:[UIColor whiteColor]];
                    bannerView;
                })];
            
//            if (titls&&titls.count>0)
//                [self.mesScrollview addSubview:({
//                    
//                    LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
//                                                                                            self.mesScrollview.bounds.size.height)
//                                                
//                                                                        delegate:self
//                                                                          titles:titls timerInterval:2.0
//                                                   currentPageIndicatorTintColor:[UIColor clearColor] pageIndicatorTintColor:[UIColor clearColor]];
//                    bannerView;
//                })];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%s fail %@",__FUNCTION__,error);
        
    }];
    
    
}

- (void)bannerView:(LCBannerView *)bannerView didClickedImageIndex:(NSInteger)index {
    
    NSLog(@"you clicked image in %@ at index: %ld", bannerView, (long)index);
    if (bannerView.titles) {
        
        //        UIStoryboard *FindStory =[UIStoryboard storyboardWithName:@"FindStoryboard" bundle:nil];
        //        UIViewController *mesCon = [FindStory instantiateViewControllerWithIdentifier:@"activityDetail"];
//        XWJNoticeViewController *notice = [self.storyboard instantiateViewControllerWithIdentifier:@"noticeController"];
//        [self.navigationController showViewController:notice sender:nil];
        NSLog(@"notice click");
    }
}
@end
