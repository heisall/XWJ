//
//  XWJIDCodeViewController.m
//  信我家
//
//  Created by Sun on 15/11/27.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJIDCodeViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "XWJResetPasswordViewController.h"
#import <SMS_SDK/SMSSDK.h>

#define MESSAGE_CONTENT @"【信我家】您的信我家验证码为：%d，感谢您的使用！"
@interface XWJIDCodeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtFieldIDCode;
@property (weak, nonatomic) IBOutlet UIButton *btnGetcode;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldPhoneNumber;
@end

@implementation XWJIDCodeViewController

int code;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setStatusBar];
    
    self.navigationItem.title = @"注册";

//    [self setNavigationBar];
    self.txtFieldIDCode.delegate = self;
    self.txtFieldPhoneNumber.delegate = self;
    
}

-(void)setStatusBar{
    //set status bar hidden
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        //iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}


-(void)sendCodeRes{

    code = arc4random()%8999 + 1000;
    

    NSString *uid = @"2735";
    NSString *phone = self.txtFieldPhoneNumber.text;
    NSString *content = [NSString stringWithFormat:MESSAGE_CONTENT,code];
    NSString *urlStr = [NSString stringWithFormat:@"http://dx.qxtsms.cn/sms.aspx?action=send&userid=%@&account=hisenseplus&password=hisenseplus&mobile=%@&content=%@&sendTime=&checkcontent=1",uid,phone,content];
//    NSString *urlStr = [NSString stringWithFormat:@"http://dx.qxtsms.cn/sms.aspx"];
//
//    NSString *contnt = [NSString stringWithFormat:@"【信我家】验证码是：%d",code];
//    NSMutableDictionary  *dic = [NSMutableDictionary dictionary];
//    [dic setValue:@"send" forKey:@"action"];
//    [dic setValue:uid forKey:@"userid" ];
//    [dic setValue:@"hisenseplus" forKey:@"account" ];
//    [dic setValue:@"hisenseplus" forKey:@"password" ];
//    [dic setValue:phone forKey:@"mobile" ];
//    [dic setValue:contnt forKey:@"content" ];
//    [dic setValue:@"" forKey:@"sendTime" ];
//    [dic setValue:@"1" forKey:@"checkcontent" ];

//    NSDictionary *dic = @{action=send&userid=%@&account=hisenseplus&password=hisenseplus&mobile=%@&content=【信我家】验证码是：%d&sendTime=&checkcontent=1",uid,phone,code};
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"url %@",urlStr);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *dict = @{@"format": @"xml"};
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];

    [manager GET:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
    }];
}

-(void)timerFired{
    
}

- (IBAction)getIDCode:(id)sender {

    [self sendCodeRes];
//    self.btnGetcode.enabled = FALSE;
    NSTimeInterval timeInterval =1.0 ;
    //定时器
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    

    /*
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS
     //这个参数可以选择是通过发送验证码还是语言来获取验证码
                            phoneNumber:self.txtFieldPhoneNumber.text
                                   zone:@"86"
                       customIdentifier:nil //自定义短信模板标识
                                 result:^(NSError *error)
     {
         
         if (!error)
         {
             NSLog(@"block 获取验证码成功");
             
         }
         else
         {
             
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                                             message:[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"getVerificationCode"]]
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                   otherButtonTitles:nil, nil];
             [alert show];
             
         }
         
     }];
     
     */
}
- (IBAction)verifyIDcode:(id)sender {
//    UIStoryboard *storyboard = [UIStoryboard  storyboardWithName:@"XWJLoginStoryboard" bundle:nil];
//    UIViewController *resetPassword = [storyboard instantiateViewControllerWithIdentifier:@"resetpwd"]          ;
//    [self.navigationController pushViewController:resetPassword animated:YES];

    
    if (code == [self.txtFieldIDCode.text intValue]) {
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setValue:self.txtFieldPhoneNumber.text forKey:@"username"];
        [defaults synchronize];
        
        UIStoryboard *storyboard = [UIStoryboard  storyboardWithName:@"XWJLoginStoryboard" bundle:nil];
        XWJResetPasswordViewController *resetPassword = [storyboard instantiateViewControllerWithIdentifier:@"resetpwd"];
        //             UIViewController *resetPassword = [[UIViewController alloc] initWithNibName:@"XWJResetPasswordViewController" bundle:nil];
        resetPassword.user = self.txtFieldPhoneNumber.text;
        [self.navigationController pushViewController:resetPassword animated:YES];
        
    }else{
        NSString *message = @"验证失败";
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertview show];
    }
    /*
    [SMSSDK  commitVerificationCode:self.txtFieldIDCode.text
     //传获取到的区号
                        phoneNumber:self.txtFieldPhoneNumber.text
                               zone:@"86"
                             result:^(NSError *error)
     {
         NSString *message ;
         if (!error)
         {
             NSLog(@"验证成功");
             message = @"验证成功";
             
             NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
             [defaults setValue:self.txtFieldPhoneNumber.text forKey:@"username"];
             [defaults synchronize];
             
             UIStoryboard *storyboard = [UIStoryboard  storyboardWithName:@"XWJLoginStoryboard" bundle:nil];
             UIViewController *resetPassword = [storyboard instantiateViewControllerWithIdentifier:@"resetpwd"];
//             UIViewController *resetPassword = [[UIViewController alloc] initWithNibName:@"XWJResetPasswordViewController" bundle:nil];
             [self.navigationController pushViewController:resetPassword animated:YES];
         }
         else
         {
             NSLog(@"验证失败");
             message = @"验证失败";
             UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             [alertview show];
         }
     }];
     */
    
}

- (BOOL)prefersStatusBarHidden
{
    return NO;//隐藏为YES，显示为NO
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)backNavItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
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
