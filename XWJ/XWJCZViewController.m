//
//  XWJCZViewController.m
//  XWJ
//
//  Created by Sun on 15/12/12.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJCZViewController.h"

#define  CELL_HEIGHT 30.0
#define  COLLECTION_NUMSECTIONS 2
#define  COLLECTION_NUMITEMS 5

@interface XWJCZViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    CGFloat collectionCellHeight;
    CGFloat collectionCellWidth;
    
    UIView *backview;
    UIView *helperView;
}
@property (weak, nonatomic) IBOutlet UITextField *shiTF;
@property (weak, nonatomic) IBOutlet UITextField *tingTF;

@property (weak, nonatomic) IBOutlet UITextField *weiTF;
@property (weak, nonatomic) IBOutlet UITextField *mianjiTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zujinTF;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *xiaoquLabel;
@property (nonatomic) NSArray *collectionData;
@property (nonatomic) NSArray *tableData;
@property (nonatomic) NSArray *tableHolderData;

@end

@implementation XWJCZViewController

static NSString *kcellIdentifier = @"collectionCellID";
static NSString *kheaderIdentifier = @"headerIdentifier";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.collectionData = [NSArray arrayWithObjects:@"床",@"衣柜",@"空调",@"电视",@"冰箱",@"洗衣机",@"天然气",@"暖气",@"热水器",@"宽带",nil];
    
    self.tableData = [NSArray arrayWithObjects:@"描述",@"联系人",@"手机号", nil];
    _tableHolderData = [NSArray arrayWithObjects:@"小区环境，交通状况等",@"请输入您的姓名",@"请输入您的手机号", nil];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZFCollectionCell" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XWJSupplementaryView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.title = @"我要出租";
}

-(void)showSortView{
    //添加半透明背景图
    backview=[[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.window.frame.size.height)];
    backview.backgroundColor=[UIColor colorWithWhite:0 alpha:0.6];
    backview.tag=4444;
    [self.view.window addSubview:backview];
    //[backview release];
    
    //    //添加helper视图
    float kHelperOrign_X=30;
    float kHelperOrign_Y=(self.view.frame.size.height-180)/2+64;
    helperView=[[UIView alloc]initWithFrame:CGRectMake(kHelperOrign_X, kHelperOrign_Y,self.view.frame.size.width-2*kHelperOrign_X, 180)];
    helperView.backgroundColor=[UIColor whiteColor];
    helperView.layer.cornerRadius=5;
    helperView.tag=1002;
    helperView.clipsToBounds=YES;
    [backview addSubview:helperView];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 40)];
//    titleLabel.text=LOCALANGER(@"JVC_DeviceList_sort");
    titleLabel.textColor=[UIColor colorWithRed:95.0/255.0 green:170.0/255.0 blue:249.0/255.0 alpha:1];
    titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [helperView addSubview:titleLabel];
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, helperView.frame.size.width, 2)];
    line.backgroundColor=[UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1];
    [helperView addSubview:line];
    NSArray *array=[[NSArray alloc]initWithObjects:@"1",@"2",@"3", nil];
    for (int i=0; i<2; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, 40+40*i, helperView.frame.size.width, 40);
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 40)];
        label.text=array[i];
        [button addSubview:label];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(button.frame.size.width-20-10, 10, 20, 20)];
//        imageView.image=[UIImage imageNamed:@"tcpUnselect"];
    
        imageView.tag=7001;
        [button addSubview:imageView];
        UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 40-1, helperView.frame.size.width, 1)];
        line.backgroundColor=[UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1];
        [button addTarget:self action:@selector(xuanze:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=60001+i;
        [button addSubview:line];
        [helperView addSubview:button];
    }
    
//    UIButton *closeButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    closeButton.frame=CGRectMake(self.view.window.frame.size.width-kHelperOrign_X-32/2, kHelperOrign_Y-32/2, 32, 32);
//    [closeButton setBackgroundImage:[UIImage imageNamed:@"help_close.png"] forState:UIControlStateNormal];
//    [closeButton addTarget:self action:@selector(closeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [backview addSubview:closeButton];
//    float space=(helperView.bounds.size.width-40-120);
//    NSArray *titles=[[NSArray alloc]initWithObjects:@"jvc_more_loginout_ok",@"jvc_more_loginout_quit", nil];
//    for (int i=0; i<2; i++) {
//        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame=CGRectMake(20+(space+60)*i, helperView.size.height-10-30, 60, 30);
//        button.tag=50001+i;
//        [button setBackgroundImage:[UIImage imageNamed:@"wel_btn"] forState:UIControlStateNormal];
////        [button setTitle:LOCALANGER(titles[i]) forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(confirmbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [helperView addSubview:button];
//    }

}

-(void)xuanze:(UIButton *)btn{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cztablecell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cztablecell"];
    }
    // Configure the cell...
    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.textColor = XWJGREENCOLOR;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITextField * content = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
    content.placeholder = [_tableHolderData objectAtIndex:indexPath.row];
    content.tag = indexPath.row;
    content.delegate = self;
    [cell.contentView addSubview:content];
    //    [cell addSubview:view];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    collectionCellHeight = self.collectionView.frame.size.height/COLLECTION_NUMSECTIONS-1;
    collectionCellWidth = self.collectionView.frame.size.width/COLLECTION_NUMITEMS-1;
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
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
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
    btn.selected = !btn.selected;
    //    [cell setBackgroundColor:[UIColor greenColor]];
    
}

//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    UIButton *btn = (UIButton *)[cell viewWithTag:1];
//    btn.selected = NO;
//}

- (IBAction)addImgae:(UIButton *)sender {
}
- (IBAction)xuanxiaoqu:(UIButton *)sender {
}
- (IBAction)sure:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
