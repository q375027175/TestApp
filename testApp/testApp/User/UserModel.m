//
//  UserModel.m
//  testApp
//
//  Created by 崔关 on 2017/12/4.
//  Copyright © 2017年 juge. All rights reserved.
//

#define CGtableName @"CGUser"
#define CGuserName @"userName"
#define CGpassWD @"passWD"

#import "UserModel.h"

@implementation UserModel

+ (void)regeistUserWithModel:(UserModel *)model result:(LoginResult)resultBlock{
    //TODO: 注册用户，数据库添加内容
    BmobObject *gameScore = [BmobObject objectWithClassName:CGtableName];
    [gameScore setObject:model.userName forKey:CGuserName];
    [gameScore setObject:model.passWD forKey:CGpassWD];
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (resultBlock) {
            resultBlock(isSuccessful);
        }
    }];
}

+ (void)loginWithModel:(UserModel *)model result:(LoginResult)resultBlock{
    BmobQuery *bquery = [BmobQuery queryWithClassName:CGtableName];
    
    //TODO: 查询语句
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",CGtableName, CGuserName, model.userName];
    
    [bquery queryInBackgroundWithBQL:sql block:^(BQLQueryResult *result, NSError *error) {
        BmobObject *object = result.resultsAry.firstObject;
        if (!error){
            NSString *passwd = [object objectForKey:CGpassWD];
            NSString *name = [object objectForKey:CGuserName];
            BOOL n = [name isEqualToString:model.userName];
            BOOL r = [passwd isEqualToString:model.passWD];
            if (!n) {
                CGLog(@"用户未注册");
                [SVProgressHUD showErrorWithStatus:@"用户未注册"];
            } else {
                if (!r) {
                    CGLog(@"密码错误");
                    [SVProgressHUD showErrorWithStatus:@"密码错误"];
                }
            }
            if (resultBlock) {
                resultBlock((n && r)?:NO);
            }
        } else {
            CGLog(@"Login error  ====  %@", error.localizedFailureReason);
            [SVProgressHUD showErrorWithStatus:error.localizedFailureReason];

            if (resultBlock) {
                resultBlock(NO);
            }
        }
    }];
}

+ (void)updateUserWithModel:(UserModel *)model result:(LoginResult)resultBlock{
    
}

@end
