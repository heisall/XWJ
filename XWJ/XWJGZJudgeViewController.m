//
//  XWJGZJudgeViewController.m
//  XWJ
//
//  Created by Sun on 15/12/12.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJGZJudgeViewController.h"
#import "RatingBar/RatingBar.h"
@interface XWJGZJudgeViewController ()
@property (weak, nonatomic) IBOutlet UIView *rateView;
@property RatingBar *bar;
@end

@implementation XWJGZJudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"评价";
    
    _bar = [[RatingBar alloc] initWithFrame:CGRectMake(200, 0, 180, 30)];
    _bar.backgroundColor = XWJColor(235.0, 237.0, 239.0);
    
    [self.rateView addSubview:_bar];
}
- (IBAction)submit:(UIButton *)sender {
    NSLog(@"rate %ld",(long)_bar.starNumber);
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
