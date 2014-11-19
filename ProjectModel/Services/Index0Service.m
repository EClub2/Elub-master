//
//  Index0Service.m
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "Index0Service.h"
#import "SVProgressHUD.h"
#import "LoginViewController.h"
#import "SharedData.h"
#import "Login.h"
#import "JSONModelLib.h"

@implementation Index0Service

-(void)loadUserDefaultsInViewController:(Index0ViewController *)viewController{

    if ([viewController.tabBarController.presentedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)viewController.tabBarController.presentedViewController;
        if ([nav.viewControllers.firstObject isKindOfClass:[LoginViewController class]]) {
            NSLog(@"用户从登录界面进来，不需要重复加载数据了");
        }
    }else{
        //用户进来需要实时刷新数据。
        SharedData *sharedData = [SharedData sharedInstance];
        NSString *name = sharedData.loginname;
        NSString *password = sharedData.password;
        NSString *urlString = [NSString stringWithFormat:LoginURL,name,password];
        NSLog(@"%@",urlString);
        [SVProgressHUD showWithStatus:@"正在加载用户信息"];
        [Login getModelFromURLWithString:urlString completion:^(Login *model,JSONModelError *error){
            if (model.status==2) {
                sharedData.user=model.info;
                [SVProgressHUD showSuccessWithStatus:@"加载完成"];
            }else{
                [SVProgressHUD showErrorWithStatus:model.error];
            }
        }];

    }
    
}

@end
