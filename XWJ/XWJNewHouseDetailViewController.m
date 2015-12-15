//
//  XWJNewHouseDetailViewController.m
//  XWJ
//
//  Created by Sun on 15/12/12.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJNewHouseDetailViewController.h"
#import "XWJNewHouseInfoViewController.h"
@interface XWJNewHouseDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *houseImg;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property (nonatomic) NSMutableArray *tableData;
@property NSMutableArray *photos;
@property NSMutableArray *buts;

@end

@implementation XWJNewHouseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 self.tableData = [NSMutableArray array];
    self.photos = [NSMutableArray array];
    
//    [self.tableData addObjectsFromArray:[NSArray arrayWithObjects:@"开盘 2015-5-1",@"地址 青岛市崂山区崂山路25号",@"状态 在售",@"优惠 交5000可98折 ", nil]];

    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 30)];
    label.textColor = XWJGREENCOLOR;
    label.text = @"楼盘信息";
    [view addSubview:label];
    [self getXinFangdetail];
    self.infoTableView.tableHeaderView = view;
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
    #define TAG 100

-(void)getXinFangdetail{
    NSString *url = GETXINFANGDETAIL_URL;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[self.dic valueForKey:@"id"]  forKey:@"areaId"];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%s success ",__FUNCTION__);
        
        if(responseObject){
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            //            XWJCity *city  = [[XWJCity alloc] init];
            
                         self.dic  = [dic objectForKey:@"house"];
            [self.photos addObjectsFromArray:[dic objectForKey:@"photo"] ];
            
            [self.tableData addObject:[NSString  stringWithFormat:@"开盘 %@",[self.dic objectForKey:@"kpsj"]]] ;
            [self.tableData addObject:[NSString  stringWithFormat:@"地址 %@",[self.dic objectForKey:@"lpmc"]]] ;
            [self.tableData addObject:[NSString  stringWithFormat:@"状态 %@",[self.dic objectForKey:@"zt"]]] ;
            [self.tableData addObject:[NSString  stringWithFormat:@"优惠 %@",[self.dic objectForKey:@"yhxx"]]] ;
            
            self.nameLabel.text = [self.dic objectForKey:@"lpmc"];
            self.moneyLabel.text = [NSString stringWithFormat:@"开盘 %@",[self.dic objectForKey:@"jiage"]];
            [self.locationBtn setTitle:[self.dic objectForKey:@"weiZhi"] forState:UIControlStateNormal];
            [self.timeBtn setTitle:[self.dic objectForKey:@"kpsj"] forState:UIControlStateNormal];
            [self.houseImg sd_setImageWithURL:[NSURL URLWithString:[self.dic objectForKey:@"zst"]] placeholderImage:[UIImage imageNamed:@"newhouse"]];
            [self.infoTableView reloadData];
            
            NSInteger count = self.photos.count;
            CGFloat width = self.view.bounds.size.width/count;
            CGFloat height = self.scrollView.bounds.size.height;
            self.scrollView.contentSize = CGSizeMake(width*count, height);
            for (int i=0; i<count; i++) {
                UIImageView *button = [[UIImageView alloc ] init];
                button.frame = CGRectMake(width*i, 0, width, height);
                button.tag = TAG+i;
                button.userInteractionEnabled = YES;

                [button sd_setImageWithURL:[NSURL URLWithString:[[self.photos objectAtIndex:i] valueForKey:@"hxt"]] placeholderImage:nil];
                
                UITapGestureRecognizer* singleRecognizer;
                singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
                //点击的次数
                singleRecognizer.numberOfTapsRequired = 1;
                [button addGestureRecognizer:singleRecognizer];

                button.backgroundColor = [UIColor whiteColor];

                [self.scrollView addSubview:button];
            }
            //            [self.houseArr addObjectsFromArray:arr];
            //            [self.tableView reloadData];
                        NSLog(@"dic %@",dic);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%s fail %@",__FUNCTION__,error);
        
    }];
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer{
//    NSInteger index = iv.tag -TAG;
    UIImageView *iv = (UIImageView *)recognizer.view;
//    NSInteger index=  recognizer.view.tag;
  XWJNewHouseInfoViewController  *vie = [self.storyboard instantiateViewControllerWithIdentifier:@"newhouseinfo"];
//    vie.dic = self.dic;
    vie.dic = [NSMutableDictionary dictionary];
    [vie.dic setDictionary:self.dic];
    [vie.dic setObject:iv.image forKey:@"image"];
    [self.navigationController showViewController:vie sender:nil];
    NSLog(@"click ");
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cztablecell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cztablecell"];
    }
    // Configure the cell...
    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)yuyuekanfang:(UIButton *)sender {
}
- (IBAction)shoucang:(UIButton *)sender {
}
- (IBAction)ditu:(UIButton *)sender {
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
