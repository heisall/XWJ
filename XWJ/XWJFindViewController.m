//
//  XWJFindViewController.m
//  信我家
//
//  Created by Sun on 15/11/28.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJFindViewController.h"
#define  COLLECTION_NUMSECTIONS 3
#define  COLLECTION_NUMITEMS 2
#define  SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define  CELL_HEIGHT 250.0
#define  vspacing 40

@implementation XWJFindViewController

static NSString *kcellIdentifier = @"findcollectionCellID";
-(void)viewDidLoad{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    ;
    collectionCellWidth  = (SCREEN_WIDTH-vspacing)/COLLECTION_NUMITEMS;

    [self.collectionView registerNib:[UINib nibWithNibName:@"XWJFindCollectionCellView" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
    
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"发现";
    self.navigationItem.leftBarButtonItem = nil;
}

#pragma mark -CollectionView datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //    collectionCellHeight = self.collectionView.frame.size.height/COLLECTION_NUMSECTIONS-1;
    //    collectionCellWidth = self.collectionView.frame.size.width/COLLECTION_NUMITEMS-1;
    return COLLECTION_NUMSECTIONS;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
//    collectionCellHeight = self.collectionView.frame.size.height/COLLECTION_NUMSECTIONS-1;
//    collectionCellWidth = self.collectionView.frame.size.width/COLLECTION_NUMITEMS-1;
    
    return COLLECTION_NUMITEMS;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    
    cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    UILabel *label1 = (UILabel *)[cell viewWithTag:1];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:2];
    UILabel *label2 = (UILabel *)[cell viewWithTag:3];
    UIImageView *imageView2 = (UIImageView *)[cell viewWithTag:4];
    UILabel *label3 = (UILabel *)[cell viewWithTag:5];
    UILabel *label4 = (UILabel *)[cell viewWithTag:6];
    label1.text = @"二手车市场";
    label2.text = @"二手转让" ;
    label3.text = @"10";
    label4.text = @"5分中前";
    imageView.image = [UIImage imageNamed:@"demo"];
    imageView2.image = [UIImage imageNamed:@"findCellMsgIcon"];
    
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width,height;
    width = self.collectionView.frame.size.width;
    //    height = (self.collectionView.frame.size.height - HEADER_HEIGHT*COLLECTION_NUMSECTIONS)/3;
    height = CELL_HEIGHT;
    return CGSizeMake(collectionCellWidth, height);
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return vspacing;
//}

//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 15, 0, 15);//分别为上、左、下、右
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    UIViewController * con = [[XWJMyMessageController alloc] init];
    //    [self.navigationController showViewController:con sender:nil];
            UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
            [cell setBackgroundColor:[UIColor greenColor]];
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    
}

@end
