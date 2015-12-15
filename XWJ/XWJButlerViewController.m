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

#import "AFNetworking.h"
#import "XWJCity.h"

@implementation XWJButlerViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"管家";
    self.navigationItem.leftBarButtonItem = nil;
//    self.titlel.text  = [[XWJCity instance].city ];
    self.btn1.frame =CGRectMake(0, 400,SCREEN_SIZE.width/4 , SCREEN_SIZE.width/4);
    self.bnt2.frame =CGRectMake(0+SCREEN_SIZE.width/4, 400,SCREEN_SIZE.width/4 , SCREEN_SIZE.width/4);
    self.bnt3.frame =CGRectMake(0+SCREEN_SIZE.width/4*2, 400,SCREEN_SIZE.width/4 , SCREEN_SIZE.width/4);
    self.bnt4.frame =CGRectMake(0+SCREEN_SIZE.width/4*3, 400,SCREEN_SIZE.width/4 , SCREEN_SIZE.width/4);
    self.bnt5.frame =CGRectMake(0, 400+SCREEN_SIZE.width/4,SCREEN_SIZE.width/4 , SCREEN_SIZE.width/4);
    self.bt6.frame =CGRectMake(0+SCREEN_SIZE.width/4, 400+SCREEN_SIZE.width/4,SCREEN_SIZE.width/4 , SCREEN_SIZE.width/4);
    self.bnt.frame =CGRectMake(0+SCREEN_SIZE.width/4*2, 400+SCREEN_SIZE.width/4,SCREEN_SIZE.width/4 , SCREEN_SIZE.width/4);

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
