//
//  XWJMFViewController.m
//  XWJ
//
//  Created by Sun on 15/12/10.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJMFViewController.h"

@interface XWJMFViewController ()
@property (weak, nonatomic) IBOutlet UITextField *shiTF;
@property (weak, nonatomic) IBOutlet UITextField *tingTF;
@property (weak, nonatomic) IBOutlet UITextField *weiTF;
@property (weak, nonatomic) IBOutlet UITextField *areaTF;
@property (weak, nonatomic) IBOutlet UITextField *cengTF;
@property (weak, nonatomic) IBOutlet UITextField *totalFloorTF;
@property (weak, nonatomic) IBOutlet UILabel *chaoxiangLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuangxiuLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@end

@implementation XWJMFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)select:(UIButton *)sender {
}
- (IBAction)selectChaoxiang:(UIButton *)sender {
}
- (IBAction)selectZhuangxiu:(UIButton *)sender {
}
- (IBAction)sure:(UIButton *)sender {
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
