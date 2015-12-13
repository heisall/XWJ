//
//  XWJFindViewController.m
//  信我家
//
//  Created by Sun on 15/11/28.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJFindViewController.h"
#import "XWJFindDetailViewController.h"
#import "XWJCity.h"
#import "UIImageView+WebCache.h"

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
    
    self.finddetailArr = [NSMutableArray array];
    self.findlistArr = [NSMutableArray array];
    collectionCellWidth  = (SCREEN_WIDTH-vspacing)/COLLECTION_NUMITEMS;

    [self.collectionView registerNib:[UINib nibWithNibName:@"XWJFindCollectionCellView" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
    
    [self getFindList:@"0"];
    

}

//参数：pageindex：第几页（从0开始）countperpage：每页条数 a_id ：小区id，types:类型 userid:用户id
-(void)getFindList:(NSString *)type{
    NSString *url = GETFINDLIST_URL;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"1"  forKey:@"a_id"];
    [dict setValue:type  forKey:@"types"];
    [dict setValue:@"0" forKey:@"pageindex"];
    [dict setValue:@"20"  forKey:@"countperpage"];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%s success ",__FUNCTION__);
        
        if(responseObject){
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            //            NSMutableArray * array = [NSMutableArray array];
            //            XWJCity *city  = [[XWJCity alloc] init];
            
            NSDictionary *dic2  = [dic objectForKey:@"data"];
            NSArray * arr = [dic2 objectForKey:@"types"];
            [self.findlistArr addObjectsFromArray:arr];
            for (NSInteger i=0; i<arr.count; i++) {
                [self getFind:i];
            }
            
            NSLog(@"dic %@",dic);
        }

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%s fail %@",__FUNCTION__,error);

    }];
}

-(void)getFind:(NSInteger )index{
    
    NSString *url = GETFIND_URL;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[[self.findlistArr objectAtIndex:index] valueForKey:@"ID"]  forKey:@"id"];
    
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%s success ",__FUNCTION__);
        
        /*
         find =         {
         "a_id" = "<null>";
         appID = 12;
         clickPraiseCount = 0;
         content = "\U661f\U5df4\U514b\U4e4b\U9ebb\U8fa3\U706b\U9505";
         id = 10;
         leaveWordCount = 0;
         nickName = "<null>";
         photo = "http://www.hisenseplus.com/HisenseUpload/find_photo/imag201512082013535403.jpg,http://www.hisenseplus.com/HisenseUpload/find_photo/imag201512082013535601.jpg,http://www.hisenseplus.com/HisenseUpload/find_photo/imag201512082013535471.jpg,http://www.hisenseplus.com/HisenseUpload/find_photo/imag201512082013535433.jpg,http://www.hisenseplus.com/HisenseUpload/find_photo/imag201512082013535420.jpg,http://www.hisenseplus.com/HisenseUpload/find_photo/imag201512082013535552.jpg";
         releaseTime = "12-08 20:13";
         shareQQCount = 0;
         shareWXCount = 0;
         types = "\U597d\U4eba\U597d\U4e8b";
         };
         */
        if(responseObject){
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSLog(@"dic %@",dic);
            NSNumber *res =[dic objectForKey:@"result"];
            if ([res intValue] == 1) {
                
                NSDictionary * find = [[dic objectForKey:@"data"] objectForKey:@"find"];
                if(find&& ((NSNull*)find!=[NSNull null])){
                    [self.finddetailArr addObject:find];
                    [self.collectionView reloadData];
                 }
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%s fail %@",__FUNCTION__,error);
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"依云小镇";
//    self.title = @"依云小镇";
    self.navigationItem.leftBarButtonItem = nil;
}

#pragma mark -CollectionView datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //    collectionCellHeight = self.collectionView.frame.size.height/COLLECTION_NUMSECTIONS-1;
    //    collectionCellWidth = self.collectionView.frame.size.width/COLLECTION_NUMITEMS-1;
//    return COLLECTION_NUMSECTIONS;
    
    NSInteger count = self.finddetailArr.count/COLLECTION_NUMITEMS;
    NSLog(@"count %ld %ld",count,self.finddetailArr.count);
    return count;
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
//    label1.text = @"二手车市场";
//    label2.text = @"二手转让" ;
//    label3.text = @"10";
//    label4.text = @"5分中前";
    
    
        label1.text = [[self.finddetailArr objectAtIndex:indexPath.row] objectForKey:@"types"];
        label2.text = [[self.finddetailArr objectAtIndex:indexPath.row] objectForKey:@"content"];
    
    NSString *urls = [[self.finddetailArr objectAtIndex:indexPath.row] objectForKey:@"photo"];
        NSString *count = [NSString stringWithFormat:@"%@",[[self.finddetailArr objectAtIndex:indexPath.row] objectForKey:@"leaveWordCount"]];
        label3.text = count;
        label4.text = [[self.finddetailArr objectAtIndex:indexPath.row] objectForKey:@"releaseTime"];
    
    NSURL *url = [NSURL URLWithString:[[urls componentsSeparatedByString:@","] objectAtIndex:0]];
    [imageView sd_setImageWithURL:url
                  placeholderImage:[UIImage imageNamed: @"demo"]];
                                    //    imageView.image = [UIImage imageNamed:@"demo"];
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
    
        XWJFindDetailViewController * con = [self.storyboard instantiateViewControllerWithIdentifier:@"findDetail"];
        con.dic = [self.finddetailArr objectAtIndex:indexPath.row];
        [self.navigationController showViewController:con sender:nil];
//            UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//            [cell setBackgroundColor:[UIColor greenColor]];
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    [cell setBackgroundColor:[UIColor clearColor]];
    
}

@end
