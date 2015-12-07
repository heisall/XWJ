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
@implementation XWJButlerViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"管家";
    self.navigationItem.leftBarButtonItem = nil;
    
    /******************** internet ********************/
    NSArray *URLs = @[@"http://admin.guoluke.com:80/userfiles/files/admin/201509181707000766.png",
                      @"http://admin.guoluke.com:80/userfiles/files/admin/201509181707000766.png",
                      @"http://img.guoluke.com/upload/201509091054250274.jpg"];
    [self.adView addSubview:({
        
        LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                                                                self.adView.bounds.size.height)
                                    
                                                            delegate:self
                                                           imageURLs:URLs
                                                    placeholderImage:nil
                                                       timerInterval:3.0f
                                       currentPageIndicatorTintColor:[UIColor redColor]
                                              pageIndicatorTintColor:[UIColor whiteColor]];
        bannerView;
    })];
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
