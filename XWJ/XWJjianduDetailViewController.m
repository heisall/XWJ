//
//  XWJjianduDetailViewController.m
//  XWJ
//
//  Created by Sun on 15/12/3.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJjianduDetailViewController.h"
#import "UIPlaceHolderTextView.h"
#define MYTV_MESSAGE_COMMANTS_FONT [UIFont boldSystemFontOfSize:14.0f] // 我的电视页面信息内容中回复内容字体大小
#define LONGIN_TEXTVIEW_SELECTED_BORDER_COLOR [UIColor colorWithRed:50/255.0 green:176/255.0 blue:178/255.0 alpha:1].CGColor // 用户名和密码框选中的时候边框颜色
#define TEXT_VIEW_MIN_HEIGH 44

@interface XWJjianduDetailViewController ()<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation XWJjianduDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
- (IBAction)click:(UIButton *)sender {
    [self addTextView];
}
- (void)clickPushButton:(UIButton *)button{
    if (!button.selected) {
        for (UIView *view in [[button superview] subviews]) {
            if ([view isKindOfClass:[UIPlaceHolderTextView class]]) {
                if (![((UITextView *)view).text isEqual:@""]) {

                    [view resignFirstResponder];
                    [self.inputTextField resignFirstResponder];
                }
            }
        }}
    button.selected = YES;
}

-(void)addTextView{
    // 自定义的view
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    customView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    
    
    // 往自定义view中添加各种UI控件(以UIButton为例)
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(250, 3, 60, TEXT_VIEW_MIN_HEIGH)];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"agreeButtonBg.png"];
    image = [image stretchableImageWithLeftCapWidth:floorf(image.size.width/2) topCapHeight:floorf(image.size.height/2)];
    UIImage *selecIedimage = [UIImage imageNamed:@"agreeButtonSelected.png"];
    selecIedimage = [selecIedimage stretchableImageWithLeftCapWidth:floorf(selecIedimage.size.width/2) topCapHeight:floorf(selecIedimage.size.height/2)];
    UIImage *disbaleImage = [UIImage imageNamed:@"agreeButtonUnenbled.png"];
    disbaleImage = [disbaleImage stretchableImageWithLeftCapWidth:floorf(disbaleImage.size.width/2) topCapHeight:floorf(disbaleImage.size.height/2)];
    
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:selecIedimage forState:UIControlStateSelected];
    [btn setBackgroundImage:disbaleImage forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(clickPushButton:) forControlEvents:UIControlEventTouchUpInside];
    btn.selected = NO;
    [customView addSubview:btn];
    
    self.inputTextField = [[UITextField alloc] init];
    self.inputTextField.inputAccessoryView = customView;
    UIPlaceHolderTextView  *keyboradTextField = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(10, 3, 235, 44)];
    keyboradTextField.placeholder = @"发表评论";
    keyboradTextField.placeholderColor = [UIColor lightGrayColor];
    keyboradTextField.maxCount = @70;
    keyboradTextField.tag = 70;
    keyboradTextField.layer.borderColor = LONGIN_TEXTVIEW_SELECTED_BORDER_COLOR;
    keyboradTextField.layer.borderWidth = 1;
    keyboradTextField.layer.masksToBounds = YES;
    keyboradTextField.layer.cornerRadius = 4;
    keyboradTextField.userInteractionEnabled = YES;
    keyboradTextField.countLabel.frame = CGRectMake(keyboradTextField.frame.size.width - 65, keyboradTextField.frame.size.height -15, 62, 14);
    [keyboradTextField addSubview:keyboradTextField.countLabel];
    [customView addSubview:keyboradTextField];
    [self.view addSubview:self.inputTextField];
    [self.inputTextField becomeFirstResponder];
    [keyboradTextField becomeFirstResponder];
    keyboradTextField.font = MYTV_MESSAGE_COMMANTS_FONT;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    btn.enabled = NO;
    btn.userInteractionEnabled = NO;
}
// 文字改变方法
- (void)textChanged:(NSNotification *)notification
{
    UIPlaceHolderTextView *textView = (UIPlaceHolderTextView*)notification.object;
    UIButton *pushButton;
    for (UIView *view in [[textView superview] subviews]) {
        if ([view isKindOfClass:UIButton.class]) {
            pushButton = (UIButton *)view;
        }
    }
    // 判断逻辑
    NSString *text = textView.text;
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (text.length == 0 || text.length > 70) {
        pushButton.enabled = NO;
        pushButton.userInteractionEnabled = NO;
    } else {
        pushButton.enabled = YES;
        pushButton.userInteractionEnabled = YES;
    }
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
