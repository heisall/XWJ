//
//  XWJResetPasswordViewController.m
//  信我家
//
//  Created by Sun on 15/11/28.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJResetPasswordViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface XWJResetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtFieldPwd;

@end

@implementation XWJResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)done:(id)sender {
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setValue:self.txtFieldPwd.text forKey:@"password"];
    [defaults synchronize];
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self regist:self.user Pass:self.txtFieldPwd.text];
    
}

-(int)regist:(NSString *) user Pass:(NSString *)pwd{
    __block int ret = 0;
    
    NSString *url = @"http://www.hisenseplus.com:8100/appPhone/rest/user/register";
//    account=qwe&password=123&type=iPhone&ip=168.0.0.1
//    NSString *account = @"2735";
//    NSString *password = self.txtFieldPhoneNumber.text;
//    NSString *content = [
//    NSString *urlStr = [NSString stringWithFormat:@"http://dx.qxtsms.cn/sms.aspx?action=send&userid=%@&account=hisenseplus&password=hisenseplus&mobile=%@&content=%@&sendTime=&checkcontent=1",uid,phone,content];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:user forKey:@"account"];
    [dict setValue:pwd forKey:@"password"];
    [dict setValue:@"iPhone" forKey:@"type"];
    [dict setValue:@"168.0.0.1" forKey:@"ip"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"res success ");

        ret = 1;
        
//        dispatch_async(dispatch_get_main_queue(), ^{
        
            [self.navigationController popToRootViewControllerAnimated:YES];
//        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"res fail ");
        ret = 0;
//        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
//        });
    }];
//    [manager Po:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"success");
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"failure");
//    }];
    return ret;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"设置密码";
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
