//
//  QKTourApplyDateMenuView.m
//  QinKun
//
//  Created by 崔关 on 2017/11/14.
//  Copyright © 2017年 聚格科技. All rights reserved.
//

#import "QKTourApplyDateMenuView.h"

@interface QKTourApplyDateMenuView()
@property (nonatomic, strong) NSArray *buttonArr;
@property (nonatomic, assign) NSInteger index;
@end

@implementation QKTourApplyDateMenuView

- (instancetype) init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addButton];
    }
    return self;
}

- (void)addButton {
    NSMutableArray *muArr = [NSMutableArray array];
    UIButton *lastButton = nil;
    
    NSInteger month = [NSDate date].month;
    NSMutableArray *titleMuArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 6; i ++) {
        NSInteger titleMonth = month + i;
        if (titleMonth > 12 ) titleMonth -= 12;
        NSString *title = [NSString stringWithFormat:@"%zd月", titleMonth];
        [titleMuArr addObject:title];
    }
    
    for (NSString *title in titleMuArr) {
        NSInteger index = [titleMuArr indexOfObject:title];
        UIButton *titleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [titleBtn setTitle:title forState:(UIControlStateNormal)];
        [titleBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        titleBtn.tag = index;
        [titleBtn addTarget:self action:@selector(menuSelectTitleWithButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [muArr addObject:titleBtn];
        [self addSubview:titleBtn];
        
        [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            if (title == titleMuArr.lastObject) {
                make.right.equalTo(@0);
            }
            if (!lastButton) {
                make.left.equalTo(@0);
            } else {
                make.width.equalTo(lastButton);
                make.left.equalTo(lastButton.mas_right);
            }
        }];
        lastButton = titleBtn;
    }
    [self layoutIfNeeded];
    self.buttonArr = [muArr copy];
    [self selectMenuViewWithIndex:0];
}

- (CGFloat)getBtnTitleWidthWithButton:(UIButton *)sender {
    NSDictionary *attribute = @{NSFontAttributeName: sender.titleLabel.font};
    CGSize  size = [sender.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 14)  options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)   attributes:attribute context:nil].size;
    return size.width;
}

- (void)menuSelectTitleWithButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(QKMenuViewSelectButtonWithIndex:)]) {
        [self selectMenuViewWithIndex:sender.tag];
        [self.delegate QKMenuViewSelectButtonWithIndex:sender.tag];
    }
}

- (void)selectMenuViewWithIndex:(NSInteger)index {
    if (index < 0) return;
    UIButton *lastButton = self.buttonArr[self.index];
    [lastButton setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    
    self.index = index;
    UIButton *titleBtn = self.buttonArr[index];
    [titleBtn setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
}

@end


