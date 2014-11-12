//
//  Index3ViewController.m
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "Index3ViewController.h"
#import "Index3Service.h"
#import "SVProgressHUD.h"
#import "UserDefaults.h"
#import "UserModel.h"
#import "Index3_1Cell.h"
#import "Index3_2Cell.h"
#import <UIImageView+WebCache.h>

@interface Index3ViewController ()
{
    NSArray *images;
    NSArray *titles;
    Index3Service *index3Service;
}
@end

@implementation Index3ViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        index3Service = [[Index3Service alloc] init];
    }
    return self;
}

-(void)loadView{
    [super loadView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    images = [[NSArray alloc] initWithObjects:@"account",@"qr_code",@"order",@"jiaoyi",@"return_suggest",@"app_load",@"ic_update",nil];
    titles = [[NSArray alloc] initWithObjects:@"我的钱包",@"我的二维码",@"我的订单",@"联系我们",@"意见反馈",@"应用推荐",@"版本更新",nil];
    [self.tableview reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableviewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 7;
            break;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    NSString *identifier;
    if (section==0) {
        identifier = @"Index3_2Cell";
        Index3_2Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        UserDefaults *userDefaults = [[UserDefaults alloc] init];
        UserModel *userModel = [userDefaults userModel];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,userModel.picture]] placeholderImage:[UIImage imageNamed:@"userIcon.jpg"]];
        cell.nickname.text = userModel.nickname;
        cell.address.text = userModel.sname;
        return cell;
    }else{
        identifier = @"Index3_1Cell";
        Index3_1Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.imgView.image = [UIImage imageNamed:images[row]];
        cell.title.text = titles[row];
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSLog(@"didSelect:%ld",(long)section);
    if (section==0) {
        [index3Service presentUserDetailViewControllerOnViewController:self];
    }else if(section==1){
        switch (row) {
            case 0:
                [index3Service presentMyWalletViewControllerOnViewController:self];
                break;
            case 1:
                [index3Service presentQRCodeViewControllerOnViewController:self];
                break;
            case 2:
                [index3Service presentMyOrderViewControllerOnViewController:self];
                break;
            case 3:
                [index3Service callInViewController:self];
                break;
            case 4:
                [index3Service presentFeedBackViewControllerOnViewController:self];
                break;
            case 5:
                [index3Service presentAppViewControllerOnViewController:self];
                break;
            case 6:
                [SVProgressHUD showSuccessWithStatus:@"已是最新版本"];
                break;
            default:
                [SVProgressHUD showImage:nil status:@"功能尚未开放，敬请期待"];
                break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:
            return 80;
            break;
        default:
            return 54;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 4;
}


@end
