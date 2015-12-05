//
//  XWJFindDetailViewController.m
//  XWJ
//
//  Created by Sun on 15/12/5.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJFindDetailViewController.h"
#import "XWJFindDetailTableViewCell.h"

#define KEY_HEADIMG @"headimg"
#define KEY_TITLE @"title"
#define KEY_TIME  @"time"
#define KEY_CONTENT @"content"

@interface XWJFindDetailViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *CommentBtn;
@property (weak, nonatomic) IBOutlet UIButton *phraseBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property  CGRect bottomRect;

@end

@implementation XWJFindDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textView.delegate = self;
    [self registerForKeyboardNotifications];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSMutableDictionary  *dic = [NSMutableDictionary dictionary];
    
    UIImage *image = [UIImage imageNamed:@"mor_icon_default"];
    [dic setObject:image forKey:KEY_HEADIMG];
    [dic setValue:@"小宝" forKey:KEY_TITLE];
    [dic setValue:@"2015-11-11" forKey:KEY_TIME];
    [dic setValue:@"保养几次了什么时候方便看车" forKey:KEY_CONTENT];
    
    
    self.array = [NSArray arrayWithObjects:dic,dic,dic,dic,dic,dic,dic, nil];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XWJFindDetailTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"findDetailCell"];
    if (!cell) {
        cell = [[XWJFindDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"findDetailCell"];
    }
    // Configure the cell...
    NSDictionary *dic = (NSDictionary *)self.array[indexPath.row];
    cell.headImgView.image = [dic objectForKey:KEY_HEADIMG];
    cell.commenterLabel.text = [dic valueForKey:KEY_TITLE];
    cell.timeLabel.text = [dic valueForKey:KEY_TIME];
    cell.contentLabel.text = [dic valueForKey:KEY_CONTENT];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    [cell.dialBtn setImage:[] forState:<#(UIControlState)#>]
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 69, self.view.bounds.size.width,1)];
    //    view.backgroundColor  = [UIColor colorWithRed:206.0/255.0 green:207.0/255.0 blue:208.0/255.0 alpha:1.0];
    //    [cell addSubview:view];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"FindStoryboard" bundle:nil];
    [self.navigationController showViewController:[storyboard instantiateViewControllerWithIdentifier:@"activityDetail"] sender:nil];
    
}

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"hight_hitht:%f",kbSize.height);
    
    self.bottomRect = self.bottomView.frame ;
    self.bottomView.frame = CGRectMake(self.bottomRect.origin.x, self.bottomRect.origin.y-kbSize.height, self.bottomRect.size.width, self.bottomRect.size.height);
    CGFloat keyboardhight;
    if(kbSize.height == 216)
    {
        keyboardhight = 0;
    }
    else
    {
        keyboardhight = 36;   //252 - 216 系统键盘的两个不同高度
    }
    [self beginAppearanceTransition:YES
                           animated:YES];
    //输入框位置动画加载
//    [self beginMoveUpAnimation:keyboardhight];
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self.bottomView.frame = self.bottomRect;

    //do something
}

- (IBAction)enroll:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [btn addTarget:self action:@selector(leaveEditMode) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *done= [[UIBarButtonItem  alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = done;
}



- (void)textViewDidEndEditing:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)leaveEditMode {
    [self.textView resignFirstResponder];
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
