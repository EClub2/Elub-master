//
//  MyWalletViewController.m
//  Club
//
//  Created by dongway on 14-8-31.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "MyWalletViewController.h"
#import "TradeListViewController.h"
#import "CreatePayViewController.h"
#import "Index3Service.h"

@interface MyWalletViewController ()<CreatePayViewDelegate>
{
    Index3Service *service;
}
@end

@implementation MyWalletViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的钱包";
    service = [[Index3Service alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"tradeRecorders"]) {
        TradeListViewController *viewController = segue.destinationViewController;
        viewController.items = self.datas;
    }

}

#pragma mark -CreatePayViewDelegate
-(void)reloadAmount{
    [service loadAmountInViewController:self];
}
@end
