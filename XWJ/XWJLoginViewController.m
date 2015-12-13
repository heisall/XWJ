//
//  XWJLoginViewController.m
//  信我家
//
//  Created by Paul on 18/11/15.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJLoginViewController.h"
#import "XWJBindHouseTableViewController.h"
#import "XWJBingHouseViewController.h"
#import "XWJTabViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "XWJHeader.h"
#import "XWJAccount.h"
@interface XWJLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tFieldUserName;
@property (weak, nonatomic) IBOutlet UITextField *tFieldPassWord;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnResetPwd;
@end

@implementation XWJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tFieldUserName.delegate = self;
    _tFieldPassWord.delegate = self;
    
    [_tFieldUserName setValue:[UIColor colorWithRed:88.0/255.0 green:176.0/255.0 blue:176.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [_tFieldPassWord setValue:[UIColor colorWithRed:88.0/255.0 green:176.0/255.0 blue:176.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [UIApplication sharedApplication].statusBarHidden = YES;

    
    NSString *username = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    NSString *pwd = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];

    if (username) {
        
        self.tFieldUserName.text = username;
    }else{
        
            self.tFieldUserName.text = @"15092245487";
    }
    if (pwd) {
        
        self.tFieldPassWord.text = pwd;
    }else
        self.tFieldPassWord.text = @"123456";
    self.navigationController.navigationBar.hidden = YES;
    
//    UIControl *controlView = [[UIControl alloc] initWithFrame:self.view.frame];
//    [controlView addTarget:self action:@selector(resiginTextFields) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:controlView];
//    controlView.backgroundColor = [UIColor clearColor];

    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        //iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    
    
    NSString *username = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    NSString *pwd = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    
    
    if (username&&pwd) {
        
//        NSString *url = @"http://www.hisenseplus.com:8100/appPhone/rest/user/userLogin";
        NSString *url = LOGIN_URL;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:username forKey:@"account"];
        [dict setValue:pwd forKey:@"password"];
        
        
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"log success ");
            
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            NSNumber * result = [dic valueForKey:@"result"];
            
            if ([result intValue]== 1) {
                NSString *sid = [[[dic objectForKey:@"data"] objectForKey:@"user"] valueForKey:@"id"];
                NSLog(@"sid %@",sid);
                [XWJAccount instance].uid = sid;
                
                XWJTabViewController *tab = [[XWJTabViewController alloc] init];
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                window.rootViewController = tab;
            }else{
                NSString *errCode = [dic objectForKey:@"errorCode"];
                UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:nil message:errCode delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                alertview.delegate = self;
                [alertview show];
            }
            

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"log fail ");
            //        dispatch_async(dispatch_get_main_queue(), ^{
            XWJTabViewController *tab = [[XWJTabViewController alloc] init];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = tab;            //        });
        }];
    }else{
    
//    if ([self.tFieldUserName.text isEqualToString:username]&&[self.tFieldPassWord.text isEqualToString:pwd]) {
        XWJTabViewController *tab = [[XWJTabViewController alloc] init];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = tab;
//    }
    }

    /*
    XWJBindHouseTableViewController *bind = [[XWJBindHouseTableViewController alloc] init];
    bind.title = @"城市选择";
    bind.dataSource = [NSArray arrayWithObjects:@"青岛市",@"济南市",@"威海市", nil];
    bind.delegate = self;
    bind->mode = HouseCity;
    [self.navigationController showViewController:bind sender:nil];
     */
}

#pragma bindhouse delegate
-(void)didSelectAtIndex:(NSInteger)index Type:(HouseMode)type{
    switch (type) {
        case HouseCity:{
            XWJBindHouseTableViewController *bind = [[XWJBindHouseTableViewController alloc] init];
            bind.title = @"小区选择";
            bind.dataSource = [NSArray arrayWithObjects:@"湖岛世家",@"花瓣里",@"依云小镇", nil];
            bind.delegate = self;
            bind->mode = HouseCommunity;
            [self.navigationController showViewController:bind sender:nil];
        }
            break;
        case HouseCommunity:{
            XWJBindHouseTableViewController *bind = [[XWJBindHouseTableViewController alloc] init];
            bind.title = @"楼座选择";
            bind.dataSource = [NSArray arrayWithObjects:@"一号楼",@"二号楼",@"三号楼", nil];
            bind.delegate = self;
            bind->mode = HouseFlour;
            [self.navigationController showViewController:bind sender:nil];
        }
            break;
        case HouseFlour:{
            XWJBindHouseTableViewController *bind = [[XWJBindHouseTableViewController alloc] init];
            bind.title = @"房间选择";
            bind.dataSource = [NSArray arrayWithObjects:@"01单元001",@"01单元002",@"01单元003", nil];
            bind.delegate = self;
            bind->mode = HouseRoomNumber;
            [self.navigationController showViewController:bind sender:nil];
        }
            break;
        case HouseRoomNumber:{
            
            XWJTabViewController *tab = [[XWJTabViewController alloc] init];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = tab;

//            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            [UIApplication sharedApplication].keyWindow.rootViewController = [story instantiateInitialViewController];
            //            XWJBingHouseViewController *bind = [[XWJBingHouseViewController alloc] initWithNibName:@"XWJBingHouseViewController" bundle:nil];
//            [self.navigationController showViewController:bind sender:nil];

        }
            break;
        default:
            break;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
