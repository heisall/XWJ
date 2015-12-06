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
#import "XWJBingHouseViewController.h"
#import "XWJBindHouseTableViewController.h"

#define  CELL_HEIGHT 150.0
#define  COLLECTION_NUMSECTIONS 3
#define  COLLECTION_NUMITEMS 1
#define  HEADER_HEIGHT 25.0

#define TAG 100

@interface XWJHomeViewController ()<XWJBindHouseDelegate>
@property (nonatomic)NSTimer *timer;
@property (nonatomic, assign) CGFloat timerInterval;
@property NSInteger currentPage;
@property BOOL isBind;
@property (nonatomic)NSInteger section;
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
    NSArray *URLs = @[@"http://admin.guoluke.com:80/userfiles/files/admin/201509181707000766.png",
                      @"http://admin.guoluke.com:80/userfiles/files/admin/201509181707000766.png",
                      @"http://img.guoluke.com/upload/201509091054250274.jpg"];
    
    [self.adScrollView addSubview:({
        
        LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                                                                self.adScrollView.bounds.size.height)
                                    
                                                            delegate:self
                                                           imageURLs:URLs
                                                    placeholderImage:nil
                                                       timerInterval:3.0f
                                       currentPageIndicatorTintColor:[UIColor redColor]
                                              pageIndicatorTintColor:[UIColor whiteColor]];
        bannerView;
    })];
    
    NSArray *titls = [NSArray arrayWithObjects:@"重要公告寒流来袭，快把装备上全1",@"重要公告寒流来袭，快把装备上全2",@"重要公告寒流来袭，快把装备上全3", nil];
    [self.mesScrollview addSubview:({
        
        LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                                                                self.mesScrollview.bounds.size.height)
                                    
                                                            delegate:self
                                                              titles:titls timerInterval:2.0
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
    NSArray * business= [NSArray arrayWithObjects:@"homegz",@"homejf",@"homets",@"homewy",@"homewy", nil];

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
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
    }
}
-(void)click:(UIButton*)sender{
    UIStoryboard * wuy = [UIStoryboard storyboardWithName:@"WuyeStoryboard" bundle:nil];
    UIViewController *wu = [wuy instantiateInitialViewController];
    
//    UIStoryboard * noticeStory = [UIStoryboard storyboardWithName:@"HomeStoryboard" bundle:nil];
//    XWJNoticeViewController *notice = [noticeStory instantiateViewControllerWithIdentifier:@"notice"];
    
    XWJNoticeViewController *notice = [self.storyboard instantiateViewControllerWithIdentifier:@"noticeController"];

    if (sender.tag-TAG == 0 && !self.isBind) {
        XWJBindHouseTableViewController *bind = [[XWJBindHouseTableViewController alloc] init];
        bind.title = @"城市选择";
        bind.dataSource = [NSArray arrayWithObjects:@"青岛市",@"济南市",@"威海市", nil];
        bind.delegate = self;
        bind->mode = HouseCity;
        [self.navigationController showViewController:bind sender:nil];
    }else{
        NSArray *jump = [NSArray arrayWithObjects:wu,notice,notice,notice,notice, nil];

        [self.navigationController showViewController:[jump objectAtIndex:sender.tag-TAG] sender:nil];

    }
}
#pragma bindhouse delegate
-(void)didSelectAtIndex:(NSInteger)index Type:(HouseMode)type{
    switch (type) {
        case HouseCity:{
            XWJBindHouseTableViewController *bind = [[XWJBindHouseTableViewController alloc] init];
            bind.title = @"小区选择";
            bind.dataSource = [NSArray arrayWithObjects:@"湖岛世家",@"花瓣里",@"依云小镇", nil];
            bind.delegate = self;
            bind->mode = HouseCommunity;
            
            self.navigationController.tabBarController.tabBar.hidden = YES;
            [self.navigationController showViewController:bind sender:nil];
        }
            break;
        case HouseCommunity:{
            XWJBindHouseTableViewController *bind = [[XWJBindHouseTableViewController alloc] init];
            bind.title = @"楼座选择";
            bind.dataSource = [NSArray arrayWithObjects:@"一号楼",@"二号楼",@"三号楼", nil];
            bind.delegate = self;
            bind->mode = HouseFlour;
            [self.navigationController showViewController:bind sender:nil];
        }
            break;
        case HouseFlour:{
            XWJBindHouseTableViewController *bind = [[XWJBindHouseTableViewController alloc] init];
            bind.title = @"房间选择";
            bind.dataSource = [NSArray arrayWithObjects:@"01单元001",@"01单元002",@"01单元003", nil];
            bind.delegate = self;
            bind->mode = HouseRoomNumber;
            [self.navigationController showViewController:bind sender:nil];
        }
            break;
        case HouseRoomNumber:{
            self.tabBarController.tabBar.hidden = NO;

//            XWJTabViewController *tab = [[XWJTabViewController alloc] init];
//            UIWindow *window = [UIApplication sharedApplication].keyWindow;
//            window.rootViewController = tab;
            
//                        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                        [UIApplication sharedApplication].keyWindow.rootViewController = [story instantiateInitialViewController];
                XWJBingHouseViewController *bind = [[XWJBingHouseViewController alloc] initWithNibName:@"XWJBingHouseViewController" bundle:nil];
                [self.navigationController showViewController:bind sender:nil];
            
        }
            break;
        default:
            break;
    }
}


- (void)bannerView:(LCBannerView *)bannerView didClickedImageIndex:(NSInteger)index {
    
    NSLog(@"you clicked image in %@ at index: %ld", bannerView, (long)index);
    if (bannerView.titles) {
        
//        UIStoryboard *FindStory =[UIStoryboard storyboardWithName:@"FindStoryboard" bundle:nil];
//        UIViewController *mesCon = [FindStory instantiateViewControllerWithIdentifier:@"activityDetail"];
        XWJNoticeViewController *notice = [self.storyboard instantiateViewControllerWithIdentifier:@"noticeController"];
        [self.navigationController showViewController:notice sender:nil];
        NSLog(@"notice click");
    }
}

-(void)setNavigationBar2{
    self.navigationItem.title = @"依云小镇";
    UIImage *image = [UIImage imageNamed:@"homemes"];
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
        
        [button1 setBackgroundImage:[UIImage imageNamed:@"house1"] forState:UIControlStateNormal];
        [button2 setBackgroundImage:[UIImage imageNamed:@"house1"] forState:UIControlStateNormal];
        [button3 setBackgroundImage:[UIImage imageNamed:@"house2"] forState:UIControlStateNormal];
        
        [button1 addTarget:self action:@selector(colleciotnCellclick:) forControlEvents:UIControlEventTouchUpInside];
        [button2 addTarget:self action:@selector(colleciotnCellclick:) forControlEvents:UIControlEventTouchUpInside];
        [button3 addTarget:self action:@selector(colleciotnCellclick:) forControlEvents:UIControlEventTouchUpInside];

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
        if (indexPath.section == 0) {
            [button1 setBackgroundImage:[UIImage imageNamed:@"homess"] forState:UIControlStateNormal];
            [button2 setBackgroundImage:[UIImage imageNamed:@"homejz"] forState:UIControlStateNormal];
            [button3 setBackgroundImage:[UIImage imageNamed:@"homexy"] forState:UIControlStateNormal];
            [button4 setBackgroundImage:[UIImage imageNamed:@"homexh"] forState:UIControlStateNormal];
            [button5 setBackgroundImage:[UIImage imageNamed:@"homedg"] forState:UIControlStateNormal];
            
        }else{
            [button1 setBackgroundImage:[UIImage imageNamed:@"shangjia1"] forState:UIControlStateNormal];
            [button2 setBackgroundImage:[UIImage imageNamed:@"shangjia1"] forState:UIControlStateNormal];
            [button3 setBackgroundImage:[UIImage imageNamed:@"shangjia2"] forState:UIControlStateNormal];
            [button4 setBackgroundImage:[UIImage imageNamed:@"shangjia3"] forState:UIControlStateNormal];
            [button5 setBackgroundImage:[UIImage imageNamed:@"shangjia4"] forState:UIControlStateNormal];
        }
        
        [button1 addTarget:self action:@selector(colleciotnCellclick:) forControlEvents:UIControlEventTouchUpInside];
        [button2 addTarget:self action:@selector(colleciotnCellclick:) forControlEvents:UIControlEventTouchUpInside];
        [button3 addTarget:self action:@selector(colleciotnCellclick:) forControlEvents:UIControlEventTouchUpInside];
        [button4 addTarget:self action:@selector(colleciotnCellclick:) forControlEvents:UIControlEventTouchUpInside];
        [button5 addTarget:self action:@selector(colleciotnCellclick:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    return cell;
    
}

-(void)colleciotnCellclick:(UIButton *)btn{
    NSLog(@"%p %@",__FUNCTION__,btn);
    
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"XWJZFStoryboard" bundle:nil];
    [self.navigationController showViewController:[story instantiateInitialViewController] sender:nil];

//    switch (self.section) {
//        case 0:
//            [self.tabBarController setSelectedIndex:2];
//            break;
//        case 1:
//            [self.tabBarController setSelectedIndex:1];
//            break;
//        case 2:
//            break;
//        default:
//            break;
//    }
 
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
    NSLog(@"%p %@",__FUNCTION__,indexPath);
    self.section = indexPath.section;

    switch (indexPath.section) {
        case 0:
            break;
            
        default:
            break;
    }
    
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
