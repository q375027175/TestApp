
//
//  LoginViewController.m
//  testApp
//
//  Created by 崔关 on 2017/12/4.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "LoginViewController.h"
#import "UserModel.h"

@interface LoginViewController ()
@property (nonatomic, strong) UITextField *name;
@property (nonatomic, strong) UITextField *passwd;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.name = [[UITextField alloc] init];
    self.name.layer.cornerRadius = 3;
    self.name.layer.borderColor = [UIColor grayColor].CGColor;
    self.name.layer.borderWidth = 1;
    self.name.placeholder = @"请输入用户名";
    [self.view addSubview:self.name];
    
    self.passwd = [[UITextField alloc] init];
    self.passwd.layer.borderColor = [UIColor grayColor].CGColor;
    self.passwd.layer.borderWidth = 1;
    self.passwd.layer.cornerRadius = 3;
    self.passwd.placeholder = @"请输入密码";
    [self.view addSubview:self.passwd];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.equalTo(@40);
    }];
    
    [self.passwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(self.name.mas_bottom).offset(15);
        make.right.equalTo(@-15);
        make.height.equalTo(@40);
    }];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:@"登陆" forState:(UIControlStateNormal)];
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(login) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwd.mas_bottom).offset(15);
        make.centerX.equalTo(@0);
        make.width.equalTo(@270);
        make.height.equalTo(@40);
    }];
    
    UIButton *regist = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [regist setTitle:@"注册" forState:(UIControlStateNormal)];
    [regist setBackgroundColor:[UIColor blueColor]];
    [regist setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [regist addTarget:self action:@selector(regist) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:regist];
    
    [regist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button.mas_bottom).offset(15);
        make.centerX.equalTo(@0);
        make.width.equalTo(@270);
        make.height.equalTo(@40);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)login {
    UserModel *model = [[UserModel alloc] init];
    model.userName = self.name.text;
    model.passWD = self.passwd.text;
    
    [UserModel loginWithModel:model result:^(BOOL result) {
        if (result) {
            [SVProgressHUD showInfoWithStatus:@"登陆成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            CGLog(@"登陆失败");
        }
    }];
}

- (void)regist {
    UserModel *model = [[UserModel alloc] init];
    model.userName = self.name.text;
    model.passWD = self.passwd.text;
    
    [UserModel regeistUserWithModel:model result:^(BOOL result) {
        if (result) {
            CGLog(@"注册成功");
            [SVProgressHUD showInfoWithStatus:@"注册成功"];
        } else {
            CGLog(@"注册失败");
            [SVProgressHUD showErrorWithStatus:@"注册失败"];
        }
    }];
}

@end
