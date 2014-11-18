//
//  CreatePayService.h
//  Club
//
//  Created by Gao Huang on 14-11-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreatePayService : NSObject
typedef void (^done)(id model);

-(void)loadCreatePayOrderInfoWithMid:(NSString *)mid andPrice:(NSString *)price finished:(done)done;

-(void)reloadAmoutAfterPopToViewControllerInNav:(UINavigationController *)nav;

@end
