//
//  UserModel.h
//  testApp
//
//  Created by 崔关 on 2017/12/4.
//  Copyright © 2017年 juge. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^loginResult)(BOOL result);

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *passWD;

+ (void)regeistUserWithModel:(UserModel *)model result:(loginResult)resultBlock;

+ (void)loginWithModel:(UserModel *)model result:(loginResult)resultBlock;

+ (void)updateUserWithModel:(UserModel *)model result:(loginResult)resultBlock;

@end
