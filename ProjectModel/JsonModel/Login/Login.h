//
//  Login3.h
//  Club
//
//  Created by Gao Huang on 14-11-19.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@interface UserInfo : JSONModel
@property(nonatomic,strong)NSString *loginname;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *realname;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *iccard;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *sname;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *version_name;
@property(nonatomic,assign)float amount_red;
@property(nonatomic,assign)float amount;
@property(nonatomic,assign)NSInteger mid;
@property(nonatomic,assign)NSInteger sid;
@end


@interface Login : JSONModel
@property(nonatomic,strong)UserInfo *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *error;
@end
