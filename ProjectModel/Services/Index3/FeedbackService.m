//
//  FeedbackService.m
//  Club
//
//  Created by dongway on 14-8-31.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "FeedbackService.h"
#import "UserDefaults.h"
#import "UserModel.h"
#import "SVProgressHUD.h"
#import "Status.h"
#import "JSONModelLib.h"
@implementation FeedbackService
-(void)submitWithContent:(NSString *)content{
    UserDefaults *userDefaults = [[UserDefaults alloc] init];
    UserModel *userModel = userDefaults.userModel;
    NSString *mid = userModel.mid;
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:mid,content, nil] forKeys:[NSArray arrayWithObjects:@"mid",@"content", nil]];
    NSString *urlString = FeedBackURL;
    if (content==nil||content.length<5) {
        [SVProgressHUD showErrorWithStatus:@"字数不够"];
        return;
    }
    [SVProgressHUD show];
    NSLog(@"%@ %@",urlString,dict);
    Status *status = [[Status alloc] init];
    [Status postModel:status toURLWithString:urlString completion:^(Status *model,JSONModelError *error){
    
    }];
    [JSONHTTPClient postJSONFromURLWithString:urlString params:dict completion:^(id object, JSONModelError *error) {
        NSNumber *status = (NSNumber *)[object objectForKey:@"status"];
        if (!error) {
            if ([status isEqualToNumber:[NSNumber numberWithInt:2]]) {
                [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"提交失败"];
            }
        }else{
            NSLog(@"%@",error);
        }
    }];
}
@end
