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

#define  CELL_HEIGHT 30.0
#define  COLLECTION_NUMSECTIONS 3
#define  COLLECTION_NUMITEMS 1
#define  HEADER_HEIGHT 25.0
@implementation XWJHomeViewController
CGFloat collectionCellHeight;
CGFloat collectionCellWidth;
static NSString *kcellIdentifier = @"homecollectionCellID";
static NSString *kheaderIdentifier = @"headerIdentifier";
NSArray *footer;
-(void)viewDidLoad{
    
//    [self setNavigationBar2];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"XWJSupplementaryView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    footer = [NSArray arrayWithObjects:@"生活信息",@"商城信息",@"房屋信息", nil];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XWJHomeCollectionCell2" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar2];
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
    //重用cell
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
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
    
    
//        cell.backgroundColor = [UIColor colorWithRed:68.0/255.0 green:70.0/255.0 blue:71.0/255.0 alpha:1.0];
    
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
    height = 120;
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
    UIViewController * con = [[XWJMyMessageController alloc] init];
    [self.navigationController showViewController:con sender:nil];
}

@end
