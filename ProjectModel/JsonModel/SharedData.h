//
//  SharedUser.h
//  DaXiaProject
//
//  Created by Gao Huang on 14-10-30.
//  Copyright (c) 2014年 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface SharedData : NSObject

@property(nonatomic,strong)UserModel *user;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *loginStatus;
@property(nonatomic,strong)NSString *iccard;
@property(nonatomic,strong)NSString *amount;
@property(nonatomic,strong)NSString *redbag;
+(id)sharedInstance;

@end
