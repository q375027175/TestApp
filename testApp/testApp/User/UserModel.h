//
//  UserModel.h
//  testApp
//
//  Created by 崔关 on 2017/12/4.
//  Copyright © 2017年 juge. All rights reserved.
//

/// 用户model

#import <Foundation/Foundation.h>

typedef void(^loginResult)(BOOL result);

/// command + option + /   加注释
/**
 用户model
 */
@interface UserModel : NSObject


/**
 用户名
*/
@property (nonatomic, copy) NSString *userName;

/**
 密码
 */
@property (nonatomic, copy) NSString *passWD;


/**
 注册用户 数据库添加内容

 @param model 用户信息
 @param resultBlock 返回结果
 */
+ (void)regeistUserWithModel:(UserModel *)model result:(loginResult)resultBlock;

/**
 登陆接口

 @param model 用户信息
 @param resultBlock 请求结果
 */
+ (void)loginWithModel:(UserModel *)model result:(loginResult)resultBlock;

/**
 更新用户信息

 @param model 用户信息
 @param resultBlock 请求结果
 */
+ (void)updateUserWithModel:(UserModel *)model result:(loginResult)resultBlock;

@end
