//
//  XWJNewHouseInfoViewController.m
//  XWJ
//
//  Created by Sun on 15/12/12.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJNewHouseInfoViewController.h"

@interface XWJNewHouseInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *houseImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;

@end

@implementation XWJNewHouseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.dic = [NSMutableDictionary dictionary];
    self.navigationItem.title =@"信息";
    // Do any additional setup after loading the view.
    self.houseImg.image = [self.dic objectForKey:@"image"];
    self.titleLabel.text = [self.dic valueForKey:@"lpmc"];
    self.sizeLabel.text =[self.dic objectForKey:@"lpmc"];
    self.totalLabel.text = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"jiage"]] ;
    self.firstLabel.text = [self.dic objectForKey:@"lpmc"];
    self.directionLabel.text =[self.dic objectForKey:@"lpmc"];
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
