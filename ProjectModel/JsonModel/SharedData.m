//
//  SharedUser.m
//  DaXiaProject
//
//  Created by Gao Huang on 14-10-30.
//  Copyright (c) 2014年 None. All rights reserved.
//

#import "SharedData.h"

@implementation SharedData

+(SharedData *)sharedInstance{
    static SharedData *sharedUser = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedUser = [[SharedData alloc] init];
    });
    return sharedUser;
}

-(void)setLoginStatus:(NSString *)loginStatus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:loginStatus forKey:@"loginStatus"];
    [userDefaults synchronize];
}

-(NSString *)loginStatus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"loginStatus"];
}

-(void)setUsername:(NSString *)username{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:username forKey:@"username"];
    [userDefaults synchronize];
}

-(NSString *)username{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"username"];
}

-(void)setPassword:(NSString *)password{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:password forKey:@"password"];
    [userDefaults synchronize];
}

-(NSString *)password{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"password"];
}

-(void)setIccard:(NSString *)iccard{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:iccard forKey:@"iccard"];
    [userDefaults synchronize];
}
-(NSString *)iccard{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"iccard"];
}

-(void)setRedbag:(NSString *)redbag{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:redbag forKey:@"redbag"];
    [userDefaults synchronize];
}
-(NSString *)redbag{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"redbag"];
}

-(void)setAmount:(NSString *)amount{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:amount forKey:@"amount"];
    [userDefaults synchronize];
}
-(NSString *)amount{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"amount"];
}

@end
