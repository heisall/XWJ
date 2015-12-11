//
//  XWJZFDetailViewController.m
//  XWJ
//
//  Created by Sun on 15/12/9.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJZFDetailViewController.h"
#import "LCBannerView.h"

#define  CELL_HEIGHT 30.0
#define  COLLECTION_NUMSECTIONS 2
#define  COLLECTION_NUMITEMS 5
@interface XWJZFDetailViewController ()<LCBannerViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    CGFloat collectionCellHeight;
    CGFloat collectionCellWidth;
}

@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *zoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuangxiuLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *loucengLabel;
@property (weak, nonatomic) IBOutlet UILabel *shoufuLabel;
@property (weak, nonatomic) IBOutlet UILabel *niandaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuegongLabel;
@property (weak, nonatomic) IBOutlet UIImageView *yaoshiView;
@property (weak, nonatomic) IBOutlet UIImageView *xuequView;
@property (weak, nonatomic) IBOutlet UILabel *miaoshuLabel;
@property (weak, nonatomic) IBOutlet UIButton *dialBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionIView;
@property (weak, nonatomic) IBOutlet UIView *teseView;
@property (nonatomic) NSArray *collectionData;

@end

@implementation XWJZFDetailViewController
static NSString *kcellIdentifier = @"collectionCellID";
static NSString *kheaderIdentifier = @"headerIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
                                       currentPageIndicatorTintColor:XWJGREENCOLOR
                                              pageIndicatorTintColor:[UIColor whiteColor]];
        bannerView;
    })];
    
//    self.type = HOUSE2;
    if (self.type == HOUSE2) {
        self.teseView.hidden = YES;
        self.collectionIView.hidden = NO;
        self.collectionData = [NSArray arrayWithObjects:@"床",@"衣柜",@"空调",@"电视",@"冰箱",@"洗衣机",@"天然气",@"暖气",@"热水器",@"宽带",nil];
        [self.collectionIView registerNib:[UINib nibWithNibName:@"ZFCollectionCell" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
        [self.collectionIView registerNib:[UINib nibWithNibName:@"XWJSupplementaryView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];

        self.collectionIView.dataSource = self;
        self.collectionIView.delegate = self;
    }
    
    NSString *title;
    switch (self.type) {
        case HOUSENEW:
            title = @"新房";
            break;
        case HOUSE2:
            title = @"二手房";
            break;
        case HOUSEZU:
            title = @"租房";
            break;
        default:
            break;
    }
    self.navigationItem.title = title;
    
}

- (void)bannerView:(LCBannerView *)bannerView didClickedImageIndex:(NSInteger)index {
    
}

#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    collectionCellHeight = self.collectionIView.frame.size.height/COLLECTION_NUMSECTIONS-1;
    collectionCellWidth = self.collectionIView.frame.size.width/COLLECTION_NUMITEMS-1;
    return COLLECTION_NUMSECTIONS;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return COLLECTION_NUMITEMS;
    
}

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
        label.textColor  = XWJGREENCOLOR;
        label.text  = @"配套设施";
    }
    UIButton *button  = (UIButton*)[view viewWithTag:2];
    button.hidden = YES;

   

    return view;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    UICollectionViewCell *cell = [self.collectionIView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    //赋值
    UIButton *btn = (UIButton *)[cell viewWithTag:1];
   
    [btn setTitle:self.collectionData[indexPath.section*COLLECTION_NUMITEMS+indexPath.row] forState:UIControlStateNormal];
    if (indexPath.row%2==0) {
        btn.selected = YES;
    }
    //    cell.backgroundColor = [UIColor colorWithRed:68.0/255.0 green:70.0/255.0 blue:71.0/255.0 alpha:1.0];
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionCellWidth, CELL_HEIGHT);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 0, 0, 0);//分别为上、左、下、右
}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    if (section == 0) {

       CGSize size =  {self.view.bounds.size.width,30};
        return size;
    }else{
        CGSize size={0,0};
        return size;
    }

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

    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIButton *btn = (UIButton *)[cell viewWithTag:1];
    btn.selected = YES;
    //    [cell setBackgroundColor:[UIColor greenColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)shoucang:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
