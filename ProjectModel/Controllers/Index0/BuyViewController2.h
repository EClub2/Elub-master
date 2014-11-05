//
//  BuyViewController2.h
//  Club
//
//  Created by Gao Huang on 14-11-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyViewController2 : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(nonatomic,strong)NSArray *datas;
@end
