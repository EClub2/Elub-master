//
//  BuyService.h
//  Club
//
//  Created by MartinLi on 14-8-23.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BuyViewController;
#import "BuyViewController2.h"
#import "GoodsViewController.h"

@interface BuyService : NSObject

@property(nonatomic,strong)NSDictionary *firstLevelData;
-(void)setSelectedColorInCollectionView:(UICollectionView *)collectionView withSelectedRow:(NSInteger)row withDatas:(NSArray *)datas;

-(void)loadGoodTypesInViewController:(BuyViewController2 *)viewController;
-(void)loadTypeGoodsWithSubtypeId:(NSString *)subtypeId andPage:(NSString *)page InViewController:(GoodsViewController *)viewController;
-(void)loadMoreTypeGoodsWithSubtypeId:(NSString *)subtypeId andPage:(NSString *)page InViewController:(GoodsViewController *)viewController;
@end
