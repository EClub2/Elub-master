//
//  BuyService.m
//  Club
//
//  Created by MartinLi on 14-8-23.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "BuyService.h"
#import "GoodDao.h"
#import "SVProgressHUD.h"
#import "UserDefaults.h"
#import "UserModel.h"
#import "MenuListViewController.h"
#import "MenuCollectionCell.h"
#import "Goods_type.h"
#import "JSONModelLib.h"
#import "Type_goods.h"
#import "MJRefresh.h"

#define MainGrayColor [UIColor colorWithRed:215.0/255 green:215.0/255 blue:215.0/255 alpha:1]
@implementation BuyService

-(void)setSelectedColorInCollectionView:(UICollectionView *)collectionView withSelectedRow:(NSInteger)row withDatas:(NSArray *)datas{
    NSInteger count = datas.count;
    for (NSInteger i=0; i<count; i++) {
        NSIndexPath *indpath = [NSIndexPath indexPathForRow:i inSection:0];
        MenuCollectionCell *cell = (MenuCollectionCell *)[collectionView cellForItemAtIndexPath:indpath];
        if (i==row) {
            cell.titleLabel.textColor = MainGreenColor;
        }else{
            cell.titleLabel.textColor = [UIColor blackColor];
        }
    }
}

/*
    加载商品类别
 */
-(void)loadGoodTypesInViewController:(BuyViewController2 *)viewController{
    [SVProgressHUD show];
    [Goods_type getModelFromURLWithString:GoodsTypeURL completion:^(Goods_type *model,JSONModelError *error){
        NSLog(@"%@",GoodsTypeURL);
        if (model.status==2) {
            viewController.datas = model.info.goods_type;
            [viewController.tableview reloadData];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        }

    }];
    
}

/*
    刷新商品
 */
-(void)loadTypeGoodsWithSubtypeId:(NSString *)subtypeId andPage:(NSString *)page InViewController:(GoodsViewController *)viewController{
    UserDefaults *userDefaults = [[UserDefaults alloc] init];
    UserModel *userModel = [userDefaults userModel];
    NSString *urlString = [NSString stringWithFormat:MainGoodsURL,userModel.mid,subtypeId,page];
    [Type_goods getModelFromURLWithString:urlString completion:^(Type_goods *model,JSONModelError *error){
        NSLog(@"%@",urlString);
        if (model.status==2) {
            NSArray *array = model.info.goods;
            if (array.count<1) {
                [SVProgressHUD showErrorWithStatus:@"没有更多数据了"];
            }else{
                viewController.datas = [NSMutableArray arrayWithArray:model.info.goods];
                [viewController.tableview reloadData];
            }
            [viewController.tableview headerEndRefreshing];
        }else{
            [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        }
    }];
}

-(void)loadMoreTypeGoodsWithSubtypeId:(NSString *)subtypeId andPage:(NSString *)page InViewController:(GoodsViewController *)viewController{
    UserDefaults *userDefaults = [[UserDefaults alloc] init];
    UserModel *userModel = [userDefaults userModel];
    NSString *urlString = [NSString stringWithFormat:MainGoodsURL,userModel.mid,subtypeId,page];
    [Type_goods getModelFromURLWithString:urlString completion:^(Type_goods *model,JSONModelError *error){
        NSLog(@"%@",urlString);
        if (model.status==2) {
            NSArray *array = model.info.goods;
            if (array.count<1) {
                [SVProgressHUD showErrorWithStatus:@"没有更多数据了"];
            }else{
                [viewController.datas addObjectsFromArray:model.info.goods];
                [viewController.tableview reloadData];
            }
            [viewController.tableview footerEndRefreshing];
        }else{
            [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        }
    }];
}


@end
