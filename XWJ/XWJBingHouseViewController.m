//
//  XWJBingHouseViewController.m
//  信我家
//
//  Created by Sun on 15/11/28.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJBingHouseViewController.h"
#import "XWJdef.h"
@interface XWJBingHouseViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property NSArray *array;
@end

@implementation XWJBingHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.txtField4.delegate = self;
    self.txtField5.delegate = self;
    self.txtField6.delegate = self;
    self.txtField7.delegate = self;
    self.txtField8.delegate = self;
    self.txtField9.delegate = self;

    self.array = [NSArray arrayWithObjects:@"房产正在我名下",@"我是业主家属",@"我是租客", nil];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.navigationItem.title = @"绑定房源";
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
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    // Configure the cell...
    
    cell.imageView.image = [UIImage imageNamed:@"jiaoseicon"];
    cell.imageView.highlightedImage = [UIImage imageNamed:@"jiaoseiconselect"];
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    cell.textLabel.textColor = XWJGRAYCOLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        
        //        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
        //        [self.navigationController showViewController:[storyboard instantiateViewControllerWithIdentifier:@"suggestStory"] sender:nil];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 1)
        return NO; // return NO to not change text
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)change:(UIButton *)sender {
}


- (IBAction)sure:(UIButton *)sender {
}

- (IBAction)bind:(UIButton *)sender {
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
