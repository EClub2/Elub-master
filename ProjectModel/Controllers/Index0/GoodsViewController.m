//
//  GoodsViewController.m
//  Club
//
//  Created by Gao Huang on 14-11-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "GoodsViewController.h"
#import "Goods_type.h"
#import "ItemCell.h"
#import <UIImageView+WebCache.h>
#import "Type_goods.h"
#import "BuyService.h"
#import "Goods_type.h"
#import "MJRefresh.h"
#import "ItemDetailViewController.h"

@interface GoodsViewController ()
{
    BuyService *buyService;
    int page;
    NSString *subtypeId;
}
@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    buyService = [[BuyService alloc] init];
    [self setSegmentedControl:self.seg WithArray:self.subtypes];
    Goods_type_subType *subtype = self.subtypes[0];
    subtypeId = subtype.subid;
    page = 1;
    [buyService loadTypeGoodsWithSubtypeId:subtypeId andPage:[NSString stringWithFormat:@"%d",page] InViewController:self];
    self.title = @"商城";
    [self setupRefresh];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"goodCellToDetail"]) {
        NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
        NSInteger row = indexPath.row;
        Type_goods_good *good = self.datas[row];
        ItemDetailViewController *viewController = segue.destinationViewController;
        viewController.goodModel = good;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    Type_goods_good *model = self.datas[row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]]];
    cell.pastPrice.text = [NSString stringWithFormat:@"原价:%@元/%@",model.price,model.unit];
    cell.currenPrice.text = [NSString stringWithFormat:@"%@元/%@",model.discount,model.unit];
    cell.discout.text = [NSString stringWithFormat:@"%0.1f折",[model.discount floatValue]/[model.price floatValue]];
    cell.name.text = model.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (IBAction)segAction:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    Goods_type_subType *subtype = self.subtypes[index];
    subtypeId = subtype.subid;
    page = 1;
    [buyService loadTypeGoodsWithSubtypeId:subtypeId andPage:[NSString stringWithFormat:@"%d",page] InViewController:self];

}

/*
 设置segmentedControl
 */
-(void)setSegmentedControl:(UISegmentedControl *)seg WithArray:(NSArray *)array{
    NSInteger num = array.count;
    if (num<=1) {
        [self.seg setHidden:YES];
    }else{
        for (NSInteger i=0; i<num; i++) {
            Goods_type_subType *subtype = array[i];
            if (i<2) {
                [seg setTitle:subtype.name forSegmentAtIndex:i];
            }else{
                [seg insertSegmentWithTitle:subtype.name atIndex:i animated:YES];
            }
        }
    }
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableview addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableview headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableview.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableview.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableview.headerRefreshingText = @"正在帮你刷新中";
    
    self.tableview.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableview.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableview.footerRefreshingText = @"正在帮你加载中";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    page = 1;
    [buyService loadTypeGoodsWithSubtypeId:subtypeId andPage:[NSString stringWithFormat:@"%d",page] InViewController:self];
}

- (void)footerRereshing
{
    page++;
    [buyService loadMoreTypeGoodsWithSubtypeId:subtypeId andPage:[NSString stringWithFormat:@"%d",page] InViewController:self];
}
@end
