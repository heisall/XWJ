//
//  XWJGuzhangViewController.m
//  XWJ
//
//  Created by Sun on 15/12/12.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJGuzhangViewController.h"
#import "XWJGZmiaoshuViewController.h"
#import "RatingBar/RatingBar.h"
#import "XWJGZTableViewCell.h"
#define TAG 100
@interface XWJGuzhangViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XWJGuzhangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"gztablecell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.title = @"故障报修";
    
    [self setNavRightItem];
}

-(void)setNavRightItem{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setTitle:@"保修" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [btn addTarget:self action:@selector(baoxiu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *done= [[UIBarButtonItem  alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = done;
}

-(void)baoxiu{
    
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
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"index path %ld",(long)indexPath.row);
    XWJGZTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[XWJGZTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

//    UILabel *label1 = [cell viewWithTag:1];
//    UILabel *label2 = [cell viewWithTag:2];
//    UILabel *label3 = [cell viewWithTag:3];
//    UILabel *label4 = [cell viewWithTag:4];
//    UIView *rate = [cell viewWithTag:5];
//    UIButton *btn  = [cell viewWithTag:6];
    cell.timelabel.text = @"提交时间";
    cell.time.text =@"12-12 12:00";
    
    cell.pingjiaBtn.tag = TAG + indexPath.row;
    if (indexPath.row%2==0) {
        
        if (!cell.pingjiaBtn.hidden) {
            RatingBar * _bar = [[RatingBar alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width-150, 0, 180, 30)];
            _bar.enable = NO;
            _bar.starNumber = 2;
            [cell.rateView addSubview:_bar];
            cell.pingjiaBtn.hidden = YES;
        }
    }else{
//        cell.pingjiaBtn.hidden = NO;
        cell.pingjiaBtn.tag = indexPath.row;
        [cell.pingjiaBtn addTarget:self action:@selector(pingjia:) forControlEvents:UIControlEventTouchUpInside];
    }
        // Configure the cell...
    
//    label1.text = @"海信湖岛世家";
//    label2.text = @"3室2厅2卫 110平米";
//    label3.text = @"青岛市四方区";
//    label4.text = @"150万元";
    
 
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    return cell;
}

-(void)pingjia:(UIButton *)btn{
    NSLog(@"btn %ld",(long)btn.tag);
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"gzpingjia"] animated:YES ];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        XWJGZmiaoshuViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"guzhangmiaoxu"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"" forKey:@""];
        [self.navigationController showViewController: detail sender:self];

    
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
