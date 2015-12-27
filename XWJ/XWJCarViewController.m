//
//  XWJCarViewController.m
//  XWJ
//
//  Created by Sun on 15/12/27.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJCarViewController.h"
#import "XWJAccount.h"
#import "XWJGouWucheTableViewCell.h"
@interface XWJCarViewController ()<UITableViewDataSource,UITableViewDelegate>
@property NSMutableArray *carListArr;
@end

@implementation XWJCarViewController
@synthesize tableView,numLabel,priceLabel,carListArr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView registerNib:[UINib nibWithNibName:@"XWJGouwucheCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    carListArr = [NSMutableArray array];
    NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
    NSMutableDictionary *d1  = [NSMutableDictionary dictionary];
    NSMutableDictionary *d2  = [NSMutableDictionary dictionary];


    [d1 setValue:@"崂山大桶水" forKey:@"goods_name"];
    [d1 setValue:@"30.00" forKey:@"price"];
    [d1 setValue:@"http://www.hisenseplus.com/ecmall/data/files/store_2/goods_193/small_201512191446342877.jpg" forKey:@"goods_image"];
   
    [d2 setValue:@"崂山大桶水" forKey:@"goods_name"];
    [d2 setValue:@"30.00" forKey:@"price"];
    [d2 setValue:@"http://www.hisenseplus.com/ecmall/data/files/store_2/goods_193/small_201512191446342877.jpg" forKey:@"goods_image"];
    
    NSArray *arr = [NSArray arrayWithObjects:d1,d2, nil];
    [dic setValue:@"农夫山泉矿泉水" forKey:@"type"];
    [dic setObject:arr forKey:@"data"];
    
    [carListArr addObject:dic];
    [carListArr addObject:dic];

    [self getCarList];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return carListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 2, SCREEN_SIZE.width, 20)];
    label.textColor = XWJGREENCOLOR;
    label.text  = [[carListArr objectAtIndex:section] objectForKey:@"type"];
    [view addSubview:label];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((NSArray*)[self.carListArr objectAtIndex:section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)taView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"index path %ld",(long)indexPath.row);
    XWJGouWucheTableViewCell *cell;
    
    cell = [taView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[XWJGouWucheTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    NSArray *arr = [[self.carListArr objectAtIndex:indexPath.section] objectForKey:@"data"];
    
    if(arr&&arr.count>0){
        cell.title.text =     [[arr objectAtIndex:indexPath.row] objectForKey:@"goods_name"];
        cell.price.text = [[arr objectAtIndex:indexPath.row] objectForKey:@"price"];

        if ([[arr objectAtIndex:indexPath.row] objectForKey:@"goods_image"]!=[NSNull null]) {

            [cell.imaView sd_setImageWithURL:[NSURL URLWithString:[[arr objectAtIndex:indexPath.row] objectForKey:@"goods_image"]] ];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    UIImage *image = [UIImage imageNamed:@"backIcon"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 30);
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
//    [btn setBackgroundImage:image forState:UIControlStateNormal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem  alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    self.tabBarController.tabBar.hidden = YES;

}

-(void)getCarList{

        NSString *url = GETCARLIST_URL;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        //    [dict setValue:@"1" forKey:@"store_id"];
        [dict setValue:[XWJAccount instance].account  forKey:@"account"];

        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%s success ",__FUNCTION__);
            
            if(responseObject){
                NSDictionary *dic = (NSDictionary *)responseObject;
                NSLog(@"dic %@",dic);
                NSString *errCode = [dic objectForKey:@"errorCode"];
                NSNumber *nu = [dic objectForKey:@"result"];

                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%s fail %@",__FUNCTION__,error);
            
        }];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;

}
-(void)edit{
    
    [tableView setEditing:!tableView.editing animated:YES];
}

- (IBAction)jiesuan:(UIButton *)sender {
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
