//
//  XWJNoticeViewController.h
//  XWJ
//
//  Created by Sun on 15/12/5.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJBaseViewController.h"
#define KEY_AD_TITLE @"Title"
#define KEY_AD_TIME  @"addTime"
#define KEY_AD_CONTENT @"description"
#define KEY_AD_CLICKCOUNT @"ClickCount"
#define KEY_AD_URL @"content"
#define KEY_AD_ID  @"id"

@interface XWJNoticeViewController : XWJBaseViewController
@property(nonatomic)NSArray *array;
@property NSString *type;
@end
