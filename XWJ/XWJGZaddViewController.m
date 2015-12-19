//
//  XWJGZaddViewController.m
//  XWJ
//
//  Created by Sun on 15/12/12.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJGZaddViewController.h"
#import "LGPhoto.h"
#import "XWJAccount.h"
@interface XWJGZaddViewController ()<LGPhotoPickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *guzhangTV;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property NSMutableArray *imageDatas;
@end

@implementation XWJGZaddViewController
#define imgtag 100
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"报修";
    for (int i = 0; i<IMAGECOUNT; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(IMAGE_WIDTH+spacing), 0,IMAGE_WIDTH, IMAGE_WIDTH)];
        imgView.tag = imgtag+i;
        [self.scrollView addSubview:imgView];
    }
}
- (IBAction)addImage:(UIButton *)sender {
    [self presentPhotoPickerViewControllerWithStyle:LGShowImageTypeImagePicker];


}

- (void)presentPhotoPickerViewControllerWithStyle:(LGShowImageType)style {
    // 创建控制器
    LGPhotoPickerViewController *pickerVc = [[LGPhotoPickerViewController alloc] initWithShowType:style];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusCameraRoll;
    // 最多能选9张图片
    pickerVc.maxCount = 6;
    pickerVc.delegate = self;
    //    self.showType = style;
    [pickerVc showPickerVc:self];
}

- (void)pickerViewControllerDoneAsstes:(NSArray *)assets isOriginal:(BOOL)original{
    
    if (assets&&assets.count>0) {
        self.imageDatas = [NSMutableArray array];
        NSUInteger count = assets.count;
        for (int i=0; i<count; i++) {
            LGPhotoAssets *asset = [assets objectAtIndex:i];
            UIImageView *imageView = [self.scrollView viewWithTag:imgtag+i];
            imageView.image = asset.compressionImage;
            
            NSData *data = UIImageJPEGRepresentation(imageView.image,1.0);
            //            NSString *aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            if (aString) {
                
                [self.imageDatas addObject:data];
            }
        }
        
        self.scrollView.contentSize =CGSizeMake((IMAGE_WIDTH+spacing) * count, IMAGE_WIDTH);
        
    }
    
}

- (IBAction)selectTime:(UIButton *)sender {
}

/*
 id	报修、投诉id	String
 evaluate	评价内容	String
 star	星级	String
 */
- (IBAction)submit:(id)sender {
    
    
    NSString *url = GETFGUZHANADD_URL;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    /*
    	
     private String userid;
     private String type;
     private String content;
     private String []pics;
     private String onDoorTime;
     */
    
    [dict setValue:self.guzhangTV.text forKey:@"content"];
    [dict setObject:self.imageDatas forKey:@"pics"];
    [dict setObject:self.gzid forKey:@"useid"];
    if (self.type ==1) {
        [dict setValue:@"维修" forKey:@"type"];
    }else
        [dict setValue:@"投诉" forKey:@"type"];
    
    [dict setValue:@"" forKey:@"onDoorTime"];
    
    
//    NSDictionary *guzhang = [NSDictionary dic];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%s success ",__FUNCTION__);
        
        if(responseObject){
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            //            NSMutableArray * array = [NSMutableArray array];
            //            XWJCity *city  = [[XWJCity alloc] init];
            
            //            NSArray *arr  = [dic objectForKey:@"data"];
            //            [self.houseArr removeAllObjects];
            //            [self.houseArr addObjectsFromArray:arr];
            //            [self.tableView reloadData];
            NSLog(@"dic %@",dic);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%s fail %@",__FUNCTION__,error);
        
    }];
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
