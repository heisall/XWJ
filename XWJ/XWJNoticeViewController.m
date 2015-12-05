//
//  XWJNoticeViewController.m
//  XWJ
//
//  Created by Sun on 15/12/5.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJNoticeViewController.h"
#import "XWJNotcieTableViewCell.h"

#define KEY_TITLE @"title"
#define KEY_TIME  @"time"
#define KEY_CONTENT @"content"
@interface XWJNoticeViewController ()<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XWJNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"通知活动";
    
    NSMutableDictionary  *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"重要公告寒流来袭，快把装备上全" forKey:KEY_TITLE];
    [dic setValue:@"0天前" forKey:KEY_TIME];
    [dic setValue:@"这几天，全国大面积降温降雪，一片银装素裹，哆嗦嗦，哆嗦嗦，" forKey:KEY_CONTENT];


    self.array = [NSArray arrayWithObjects:dic,dic,dic,dic,dic,dic,dic, nil];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

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
    return 120.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XWJNotcieTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"noticecell"];
    if (!cell) {
        cell = [[XWJNotcieTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"noticecell"];
    }
    // Configure the cell...
    NSDictionary *dic = (NSDictionary *)self.array[indexPath.row];
    cell.titleLabel.text = [dic valueForKey:KEY_TITLE];
    cell.timeLabel.text = [dic valueForKey:KEY_TIME];
    cell.contentLabel.text = [dic valueForKey:KEY_CONTENT];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                         
    //    [cell.dialBtn setImage:[] forState:<#(UIControlState)#>]
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 69, self.view.bounds.size.width,1)];
    //    view.backgroundColor  = [UIColor colorWithRed:206.0/255.0 green:207.0/255.0 blue:208.0/255.0 alpha:1.0];
    //    [cell addSubview:view];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"FindStoryboard" bundle:nil];
    [self.navigationController showViewController:[storyboard instantiateViewControllerWithIdentifier:@"activityDetail"] sender:nil];

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
