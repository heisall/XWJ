//
//  XWJZFViewController.m
//  XWJ
//
//  Created by Sun on 15/12/6.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJZFViewController.h"
#import "XWJZFTableViewCell.h"
#import "XWJdef.h"
#import "XWJZFDetailViewController.h"
#import "XWJMFViewController.h"
#import "XWJCZViewController.h"
#import "XWJNewHouseDetailViewController.h"
@interface XWJZFViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightcontraint;
@property NSMutableArray *houseArr;
@end

@implementation XWJZFViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if (self.type != HOUSENEW) {
    
        NSArray *array = [NSArray arrayWithObjects:@"区域",@"总价",@"户型",@"面积", nil];
        CGFloat width = [UIScreen mainScreen].bounds.size.width/4;
        CGFloat height  = self.selectView.bounds.size.height;
        for (int i = 0 ; i<4; i++) {
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:XWJGREENCOLOR forState:UIControlStateNormal];
            btn.frame = CGRectMake(i*width, 0, width, 40);
            [btn setImage:[UIImage imageNamed:@"xinfangarrow"] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.bounds.size.width-20, 0, 0)];
            btn.tag = i;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self.selectView addSubview:btn];
        }
    }else{
        
        NSLayoutConstraint *conStr= [NSLayoutConstraint constraintWithItem:_selectView
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_selectView
                                                                 attribute:NSLayoutAttributeHeight
                                                                multiplier:0
                                                                  constant:0];
        
        [_selectView removeConstraint:_heightcontraint];
        [_selectView addConstraint:conStr];
     
     
    }
    self.selectView.frame = CGRectZero;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSString *title ;
    switch (self.type) {
        case HOUSENEW:
            title = @"新房";
            break;
        case HOUSE2:{
            title = @"二手房";
            [self setRigthNavItem:0];
        }
            break;
        case HOUSEZU:{
            title = @"租房";
            [self setRigthNavItem:1];
        }
            break;
        default:
            break;
    }
    
    self.houseArr = [NSMutableArray array];
    
    [self getXinFang];
    self.navigationItem.title = title;
}

-(void)getXinFang{
    NSString *url = GETXINFANG_URL;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"1"  forKey:@"a_id"];
    [dict setValue:@"0" forKey:@"pageindex"];
    [dict setValue:@"20"  forKey:@"countperpage"];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%s success ",__FUNCTION__);
        
        if(responseObject){
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            //            NSMutableArray * array = [NSMutableArray array];
            //            XWJCity *city  = [[XWJCity alloc] init];
            
            NSArray *arr  = [dic objectForKey:@"data"];
            [self.houseArr addObjectsFromArray:arr];
            [self.tableView reloadData];
            NSLog(@"dic %@",dic);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%s fail %@",__FUNCTION__,error);
        
    }];
}

-(void)setRigthNavItem:(int)d{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 40);
    NSArray *array = [NSArray arrayWithObjects:@"我要卖房",@"我要出租", nil];
    [btn setTitle:[array objectAtIndex:d] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [btn addTarget:self action:@selector(woyao) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *done= [[UIBarButtonItem  alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = done;
}

-(void)woyao{
    switch (self.type) {
        case HOUSE2:{
            XWJMFViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"sell2house"];
            [self.navigationController showViewController:view sender:nil];
        }
            break;
        case HOUSEZU:{
            XWJCZViewController  *view = [self.storyboard instantiateViewControllerWithIdentifier:@"mychuzu"];
            [self.navigationController showViewController:view sender:nil];

        }
            break;
        default:
            break;
    }
}

-(void)click:(UIButton *)btn{
    NSLog(@"click");
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 30.0;
//}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @"物业员工";
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.houseArr.count;
//    return 10;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XWJZFTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"zftablecell"];
    if (!cell) {
        cell = [[XWJZFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"zftablecell"];
    }
    // Configure the cell...
//    cell.headImageView.image = [UIImage imageNamed:@"xinfangbackImg"];
//    cell.label1.text = @"海信湖岛世家";
//    cell.label2.text = @"3室2厅2卫 110平米";
//    cell.label3.text = @"青岛市四方区";
//    cell.label4.text = @"150万元";
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[[self.houseArr objectAtIndex:indexPath.row] objectForKey:@"xzst"]] placeholderImage:[UIImage imageNamed:@"xinfangbackImg"]];
    
    NSString * qu = [NSString stringWithFormat:@"%@%@",[[self.houseArr objectAtIndex:indexPath.row] objectForKey:@"cityName"],[[self.houseArr objectAtIndex:indexPath.row] objectForKey:@"quyu"]];
//    NSString*money = [[NSString stringWithFormat:@"%@",[[self.houseArr objectAtIndex:indexPath.row] objectForKey:@"jiage"]] ;
NSString*money = [NSString stringWithFormat:@"%@",[[self.houseArr objectAtIndex:indexPath.row] objectForKey:@"jiage"]];
        cell.label1.text = [[self.houseArr objectAtIndex:indexPath.row] objectForKey:@"lpmc"];
        cell.label2.text = [[self.houseArr objectAtIndex:indexPath.row] objectForKey:@"zt"];
        cell.label3.text = qu;
        cell.label4.text = money;
    
    //    [cell.dialBtn setImage:[] forState:<#(UIControlState)#>]
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 69, self.view.bounds.size.width,1)];
    //    view.backgroundColor  = [UIColor colorWithRed:206.0/255.0 green:207.0/255.0 blue:208.0/255.0 alpha:1.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    [cell addSubview:view];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type == HOUSE2||self.type==HOUSEZU) {
        XWJZFDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"zfdatail"];
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [dic setValue:@"" forKey:@""];
//        detail.dic = [self.houseArr objectAtIndex:indexPath.row];
        detail.type = self.type;
        [self.navigationController showViewController: detail sender:self];
    }else{
        
        XWJNewHouseDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"newhousedetail"];
        detail.dic = [self.houseArr objectAtIndex:indexPath.row];
        [self.navigationController showViewController:detail sender:self];
    }

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
