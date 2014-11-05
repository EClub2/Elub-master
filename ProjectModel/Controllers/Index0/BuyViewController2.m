//
//  BuyViewController2.m
//  Club
//
//  Created by Gao Huang on 14-11-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "BuyViewController2.h"
#import "BuyGoodTypeCell.h"
#import <UIImageView+WebCache.h>
#import "Goods_type.h"
#import "BuyService.h"
#import "GoodsViewController.h"

@interface BuyViewController2 ()
{
    BuyService *buyService;
}
@end

@implementation BuyViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    buyService = [[BuyService alloc] init];
    [buyService loadGoodTypesInViewController:self];
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
    if ([segue.identifier isEqualToString:@"goodTypeCellToGoods"]) {
        NSIndexPath *indexpath = [self.tableview indexPathForSelectedRow];
        NSInteger row = indexpath.row;
        Goods_type_goods_type *goods_type = self.datas[row];
        NSArray *subtypes = goods_type.subtype;
        GoodsViewController *viewController = segue.destinationViewController;
        viewController.subtypes = subtypes;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyGoodTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyGoodTypeCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    Goods_type_goods_type *goods_type = self.datas[row];
    NSArray *subtypes = goods_type.subtype;
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,goods_type.picture]]];
    cell.firstType.text = goods_type.name;
    cell.secondType.text = [self subtypeStringFromArray:subtypes];
    return cell;
}

/*
    二级目录的组合
 */
-(NSString *)subtypeStringFromArray:(NSArray *)subtypes{
    NSMutableString *subtypeString = [[NSMutableString alloc] initWithString:@""];
    for (Goods_type_subType *subtype in subtypes) {
        if (subtype==subtypes.lastObject) {
            [subtypeString appendString:[NSString stringWithFormat:@"%@",subtype.name]];
        }else{
            [subtypeString appendString:[NSString stringWithFormat:@"%@/",subtype.name]];
        }
    }
    return subtypeString;
}

@end
