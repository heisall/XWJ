//
//  XWJFindViewController.h
//  信我家
//
//  Created by Sun on 15/11/28.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJBaseViewController.h"

@interface XWJFindViewController : XWJBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>{
    CGFloat collectionCellWidth;
    CGFloat collectionCellHeight;

}
@property (weak, nonatomic) IBOutlet UIView *motionView;
@property (weak, nonatomic) IBOutlet UIView *publicView;
@property (weak, nonatomic) IBOutlet UIButton *mesBtn;
@property NSMutableArray *findlistArr;
@property NSMutableArray *finddetailArr;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic)NSArray *array;
@end
