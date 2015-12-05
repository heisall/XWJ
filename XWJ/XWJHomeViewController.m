//
//  XWJHomeViewController.m
//  信我家
//
//  Created by Sun on 15/11/28.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJHomeViewController.h"
#import "XWJHeader.h"
#import "XWJMyMessageController.h"
#import "XWJNoticeViewController.h"
#import "LCBannerView.h"
#define  CELL_HEIGHT 150.0
#define  COLLECTION_NUMSECTIONS 3
#define  COLLECTION_NUMITEMS 1
#define  HEADER_HEIGHT 25.0

#define TAG 100

@interface XWJHomeViewController ()
@property (nonatomic)NSTimer *timer;
@property (nonatomic, assign) CGFloat timerInterval;
@property NSInteger currentPage;
@end
@implementation XWJHomeViewController
CGFloat collectionCellHeight;
CGFloat collectionCellWidth;
static NSString *kcellIdentifier = @"homecollectionCellID2";
static NSString *kcellIdentifier1 = @"homecollectionCellID3";
static NSString *kheaderIdentifier = @"headerIdentifier";
NSArray *footer;
-(void)viewDidLoad{
    
//    [self setNavigationBar2];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"XWJSupplementaryView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    footer = [NSArray arrayWithObjects:@"生活信息",@"商城信息",@"房屋信息", nil];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XWJHomeCollectionCell2" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"XWJHomeCollectionCell3" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier1];
    
    /******************** internet ********************/
    NSArray *URLs = @[@"http://admin.guoluke.com:80/userfiles/files/admin/201509181708260671.png",
                      @"http://admin.guoluke.com:80/userfiles/files/admin/201509181707000766.png",
                      @"http://img.guoluke.com/upload/201509091054250274.jpg"];
    
    [self.adScrollView addSubview:({
        
        LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                                                                200.0f)
                                    
                                                            delegate:self
                                                           imageURLs:URLs
                                                    placeholderImage:nil
                                                       timerInterval:2.0f
                                       currentPageIndicatorTintColor:[UIColor redColor]
                                              pageIndicatorTintColor:[UIColor whiteColor]];
        bannerView;
    })];
    
    NSArray *titls = [NSArray arrayWithObjects:@"元旦放假通知1",@"元旦放假通知2",@"元旦放假通知3", nil];
    [self.mesScrollview addSubview:({
        
        LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                                                                self.mesScrollview.bounds.size.height)
                                    
                                                            delegate:self
                                                              titles:titls timerInterval:5.0
                                       currentPageIndicatorTintColor:[UIColor clearColor] pageIndicatorTintColor:[UIColor clearColor]];
        bannerView;
    })];
    
    /*
    self.timerInterval = 2.0;
    CGFloat h = self.mesScrollview.bounds.size.height;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;

    for (int i=0; i<3; i++) {
        UIButton * btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*w, 0, w,h);
        btn.tag = i;
        btn.titleLabel.text = [NSString stringWithFormat:@"元旦放假通知%d",i];
        [btn addTarget:self action:@selector(msgClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.mesScrollview addSubview:btn];
    }
    self.mesScrollview.contentSize = CGSizeMake(w*3, h);
    */
}

-(void)msgClick:(UIButton *)sender{
    NSLog(@"click %ld",(long)sender.tag);
}

#pragma mark - Timer

- (void)addTimer {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timerInterval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    
    if (self.timer) {
        
        [self.timer invalidate];
        
        self.timer = nil;
    }
}

- (void)nextImage {
    
    [self.mesScrollview setContentOffset:CGPointMake((_currentPage + 2) * self.mesScrollview.frame.size.width, 0)
                             animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    NSLog(@"scrolview width %f height %f",self.scrollView.bounds.size.width,self.scrollView.bounds.size.height);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar2];
    NSLog(@"scrolview width %f height %f",self.scrollView.bounds.size.width,self.scrollView.bounds.size.height);
    NSLog(@"view width %f height %f",self.view.bounds.size.width,self.view.bounds.size.height);

    NSArray * arr= [NSArray arrayWithObjects:@"故障报修",@"在线缴费",@"我要投诉",@"物业监督",@"物业监督", nil];
    NSArray * business= [NSArray arrayWithObjects:@"mine1",@"mine2",@"mine3",@"mine4",@"mine5", nil];

    CGFloat width = self.view.bounds.size.width/4;
    CGFloat height = self.scrollView.bounds.size.height;
    self.scrollView.contentSize = CGSizeMake(width*5, height);
    for (int i=0; i<5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(width*i, 0, width, height);
        button.tag = TAG+i;
        button.titleLabel.text= [arr objectAtIndex:i];
        button.contentMode = UIViewContentModeCenter;
        [button setImage:[UIImage imageNamed:[business objectAtIndex:i] ] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
    }
}
-(void)click:(UIButton*)sender{
    UIStoryboard * wuy = [UIStoryboard storyboardWithName:@"WuyeStoryboard" bundle:nil];
    UIViewController *wu = [wuy instantiateInitialViewController];
    
    UIStoryboard * noticeStory = [UIStoryboard storyboardWithName:@"HomeStoryboard" bundle:nil];
    XWJNoticeViewController *notice = [noticeStory instantiateViewControllerWithIdentifier:@"notice"];

    NSArray *jump = [NSArray arrayWithObjects:wu,notice,notice,notice,notice, nil];

    [self.navigationController showViewController:[jump objectAtIndex:sender.tag-TAG] sender:nil];


}

- (void)bannerView:(LCBannerView *)bannerView didClickedImageIndex:(NSInteger)index {
    
    NSLog(@"you clicked image in %@ at index: %ld", bannerView, (long)index);
    if (bannerView.titles) {
        
        UIStoryboard *FindStory =[UIStoryboard storyboardWithName:@"FindStoryboard" bundle:nil];
        UIViewController *mesCon = [FindStory instantiateViewControllerWithIdentifier:@"activityDetail"];
        [self.navigationController showViewController:mesCon sender:nil];
        NSLog(@"mes click");
    }
}

-(void)setNavigationBar2{
    self.navigationItem.title = @"XX城";
    UIImage *image = [UIImage imageNamed:@"liebiao"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [btn addTarget:self action:@selector(showList) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem  alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    self.navigationItem.leftBarButtonItem = nil;
    
}


#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//    collectionCellHeight = self.collectionView.frame.size.height/COLLECTION_NUMSECTIONS-1;
//    collectionCellWidth = self.collectionView.frame.size.width/COLLECTION_NUMITEMS-1;
    return COLLECTION_NUMSECTIONS;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    collectionCellHeight = self.collectionView.frame.size.height/COLLECTION_NUMSECTIONS-1;
    collectionCellWidth = self.collectionView.frame.size.width/COLLECTION_NUMITEMS-1;

    return COLLECTION_NUMITEMS;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    
    if (indexPath.section == 2) {
        cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier1 forIndexPath:indexPath];
        UIButton *button1 = (UIButton *)[cell viewWithTag:1];
        UIButton *button2 = (UIButton *)[cell viewWithTag:2];
        UIButton *button3 = (UIButton *)[cell viewWithTag:3];
        
        //    NSString *imageName = [NSString stringWithFormat:@"mor_icon_default"];
        
        [button1 setBackgroundImage:[UIImage imageNamed:@"mor_icon_default"] forState:UIControlStateNormal];
        [button2 setBackgroundImage:[UIImage imageNamed:@"mor_icon_default"] forState:UIControlStateNormal];
        [button3 setBackgroundImage:[UIImage imageNamed:@"mor_icon_default"] forState:UIControlStateNormal];

    }else{
        //重用cell
        cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
        //赋值
        UIButton *button1 = (UIButton *)[cell viewWithTag:1];
        UIButton *button2 = (UIButton *)[cell viewWithTag:2];
        UIButton *button3 = (UIButton *)[cell viewWithTag:3];
        UIButton *button4 = (UIButton *)[cell viewWithTag:4];
        UIButton *button5 = (UIButton *)[cell viewWithTag:5];

        //    NSString *imageName = [NSString stringWithFormat:@"mor_icon_default"];
         
        [button1 setBackgroundImage:[UIImage imageNamed:@"mor_icon_default"] forState:UIControlStateNormal];
        [button2 setBackgroundImage:[UIImage imageNamed:@"mor_icon_default"] forState:UIControlStateNormal];
        [button3 setBackgroundImage:[UIImage imageNamed:@"mor_icon_default"] forState:UIControlStateNormal];
        [button4 setBackgroundImage:[UIImage imageNamed:@"mor_icon_default"] forState:UIControlStateNormal];
        [button5 setBackgroundImage:[UIImage imageNamed:@"mor_icon_default"] forState:UIControlStateNormal];
    
    }
    return cell;
    
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
//        reuseIdentifier = kfooterIdentifier;
    }else{
        reuseIdentifier = kheaderIdentifier;
    }
    
    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    
    UILabel *label = (UILabel *)[view viewWithTag:1];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        label.text = footer[indexPath.section];
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        view.backgroundColor = [UIColor lightGrayColor];
        label.text = footer[indexPath.section];
    }
    
    UIButton *button  = (UIButton*)[view viewWithTag:0];
    return view;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width,height;
    width = self.collectionView.frame.size.width;
//    height = (self.collectionView.frame.size.height - HEADER_HEIGHT*COLLECTION_NUMSECTIONS)/3;
    height = CELL_HEIGHT;
//        if (indexPath.item == 0) {
//            return CGSizeMake(width, height);
//        }
//        return CGSizeMake(width/2, height/2);
    
    return CGSizeMake(width, height);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 0, 0, 0);//分别为上、左、下、右
}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={self.view.bounds.size.width,HEADER_HEIGHT};
    return size;
}
//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size={0,0};
    return size;
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UIViewController * con = [[XWJMyMessageController alloc] init];
//    [self.navigationController showViewController:con sender:nil];
//        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//        [cell setBackgroundColor:[UIColor greenColor]];
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];

}
-(void)showList{
//    UIStoryboard *wuyStory = [UIStoryboard storyboardWithName:@"WuyeStoryboard" bundle:nil];
//    [self.navigationController showViewController:[wuyStory instantiateInitialViewController] sender:nil];
    UIViewController * con = [[XWJMyMessageController alloc] init];
    [self.navigationController showViewController:con sender:nil];
}

@end
