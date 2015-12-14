//
//  XWJIDCodeViewController.m
//  信我家
//
//  Created by Sun on 15/11/27.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJIDCodeViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLResponseSerialization.h"
#import "XWJResetPasswordViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "XWJUrl.h"
@interface XWJIDCodeViewController (){
    int code;
    int timeTick;
}
@property (weak, nonatomic) IBOutlet UITextField *txtFieldIDCode;
@property (weak, nonatomic) IBOutlet UIButton *btnGetcode;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *numlabel;
@property NSTimer *timer;
@end

@implementation XWJIDCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setStatusBar];
    timeTick = 61;
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
    NSString *urlStr = [NSString stringWithFormat:IDCODE_URL,uid,phone,content];
    
    NSLog(@"url %@",urlStr);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer new];

    [manager GET:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
    }];
}


-(void)timeFireMethod
{
    timeTick--;
    if(timeTick==0){
        [_timer invalidate];
        self.numlabel.hidden = YES;
        _btnGetcode.enabled = YES;
        timeTick = 61;
//        [_btnGetcode setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }else
    {
        NSString *str = [NSString stringWithFormat:@"%d",timeTick];
        if (_numlabel.hidden) {
            _numlabel.hidden = NO;
        }
        _numlabel.text = str;
//        [_btnGetcode setTitle:str forState:UIControlStateNormal];
    }
}

- (IBAction)getIDCode:(id)sender {

    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    _btnGetcode.enabled = NO;
  
    [self sendCodeRes];
    
    
    
//    self.btnGetcode.enabled = FALSE;
//    NSTimeInterval timeInterval =1.0 ;
    //定时器
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    

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
