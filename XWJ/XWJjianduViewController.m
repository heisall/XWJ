//
//  XWJjianduViewController.m
//  XWJ
//
//  Created by Sun on 15/12/2.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJjianduViewController.h"
#import "WuyeTableViewCell.h"
@interface XWJjianduViewController ()

@property (weak, nonatomic) IBOutlet UIView *adView;
@property(nonatomic)UIScrollView *scrollview;
@end
#define MJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@implementation XWJjianduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
    /******************** internet ********************/
    NSArray *URLs = @[@"http://admin.guoluke.com:80/userfiles/files/admin/201509181708260671.png",
                      @"http://admin.guoluke.com:80/userfiles/files/admin/201509181707000766.png",
                      @"http://img.guoluke.com/upload/201509091054250274.jpg"];
    
    [self.adScrollView addSubview:({
        
        LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                                                                300.0f)
                                    
                                                            delegate:self
                                                           imageURLs:URLs
                                                    placeholderImage:nil
                                                       timerInterval:5.0f
                                       currentPageIndicatorTintColor:[UIColor redColor]
                                              pageIndicatorTintColor:[UIColor whiteColor]];
        bannerView;
    })];

//    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40.0)];
////    view.backgroundColor = [UIColor grayColor];
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 30)];
//    view.backgroundColor = [UIColor whiteColor];
//    title.text = @"物业员工";
//    title.textColor  = MJColor(0, 147, 141);
//    [view addSubview:title];
//    self.tableView.tableHeaderView = view;
}

- (void)bannerView:(LCBannerView *)bannerView didClickedImageIndex:(NSInteger)index {
        
    UIViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"jiandudetail"];
    [self.navigationController showViewController:detail sender:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"物业监督";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WuyeTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"wuyecell"];
    if (!cell) {
        cell = [[WuyeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wuyecell"];
    }
    // Configure the cell...
    cell.headImg.image = [UIImage imageNamed:@"mor_icon_default"];
    cell.nameLabel.text = @"王琳";
    cell.positionLabel.text = @"主管";
    cell.photoLabel.text = @"13666666666";
//    [cell.dialBtn setImage:[] forState:<#(UIControlState)#>]
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 69, self.view.bounds.size.width,1)];
//    view.backgroundColor  = [UIColor colorWithRed:206.0/255.0 green:207.0/255.0 blue:208.0/255.0 alpha:1.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell addSubview:view];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
//        [self.navigationController showViewController:[storyboard instantiateViewControllerWithIdentifier:@"suggestStory"] sender:nil];
    }
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
