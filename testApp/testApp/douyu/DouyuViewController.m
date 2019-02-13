//
//  DouyuViewController.m
//  testApp
//
//  Created by juge on 2017/10/28.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "DouyuViewController.h"
#import <VKVideoPlayer/VKVideoPlayerViewController.h>
#import "NSString+MD5.h"

@interface DouyuViewController () <UITableViewDelegate, UITableViewDataSource, VKVideoPlayerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) VKVideoPlayerViewController *playerVC;

@end

@implementation DouyuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    if (board.string) {
        self.array = @[board.string];
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    NSString *roomId = @"288016";
    long long time = [[NSDate date] timeIntervalSince1970];
    NSString *auth = [NSString stringWithFormat:@"room/%@?aid=ios&clientsys=ios&time=%lld", roomId, time];
    NSString *url = [NSString stringWithFormat:@"http://capi.douyucdn.cn/api/v1/room/%@?aid=ios&client_sys=ios&time=%lld&auth=%@", roomId, time, [auth md5]];
    
    self.array = @[url];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self showPlayerVCWithUrl:self.array[indexPath.row]];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}


- (void)showPlayerVCWithUrl:(NSString *)url {
    [self.playerVC playVideoWithStreamURL:[NSURL URLWithString:url?:@""]];
    [self.navigationController presentViewController:self.playerVC animated:YES completion:nil];
}

- (VKVideoPlayerViewController *)playerVC {
    if (!_playerVC) {
        _playerVC = [[VKVideoPlayerViewController alloc] init];
        _playerVC.player.delegate = self;
    }
    return _playerVC;
}

- (void)handleErrorCode:(VKVideoPlayerErrorCode)errorCode track:(id<VKVideoPlayerTrackProtocol>)track customMessage:(NSString*)customMessage {
    UIAlertController *alert = [[UIAlertController alloc] init];
    alert.title = @"报错了";
    alert.message = customMessage;
    [alert addAction:[UIAlertAction actionWithTitle:@"滚" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
}

@end
