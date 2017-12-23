//
//  HuadongHeaderView.m
//  testApp
//
//  Created by juge on 2017/11/3.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "HuadongHeaderView.h"

#define scrollPageWidth self.frame.size.width
#define scrollPageHeight self.frame.size.height

@interface HuadongHeaderView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UIImageView *leftImg;
@property (nonatomic, strong) UIImageView *midImg;
@property (nonatomic, strong) UIImageView *rightImg;
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation HuadongHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.imgArr = @[@"", @"", @"", @"", @""];
    }
    return self;
}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    [self setViews];
    [self setLayoutViews];
    [self revertImg];
}

- (void)setViews {
    [self addSubview:self.scroll];
    [self.scroll addSubview:self.leftImg];
    [self.scroll addSubview:self.midImg];
    [self.scroll addSubview:self.rightImg];
}

- (void)setLayoutViews {
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 0) {
        self.pageIndex --;
        if (self.pageIndex < 0) self.pageIndex = self.imgArr.count - 1;
        [self revertImg];
    } else if (scrollView.contentOffset.x == scrollPageWidth * 2) {
        self.pageIndex ++;
        if (self.pageIndex >= self.imgArr.count) self.pageIndex = 0;
        [self revertImg];
    }
}

- (void)revertImg {
    if (self.imgArr.count <= 0) return;
    CGLog(@"%zd", self.pageIndex);
    self.scroll.contentOffset = CGPointMake(scrollPageWidth, 0);
    
    NSString *leftImg = [self getImageNameWithType:0];;
    NSString *midImg = [self getImageNameWithType:1];;
    NSString *rightImg = [self getImageNameWithType:2];;

    self.leftImg.image = [UIImage imageNamed:leftImg];
    self.midImg.image = [UIImage imageNamed:midImg];
    self.rightImg.image = [UIImage imageNamed:rightImg];
}

- (NSString *)getImageNameWithType:(NSInteger) type {
    NSInteger index = 0;
    switch (type) {
        case 0:
        {
            index = self.pageIndex - 1;
        }
            break;
            
        case 1:
        {
            index = self.pageIndex;
        }
            break;
            
        case 2:
        {
            index = self.pageIndex + 1;
        }
            break;
            
        default:
            break;
    }
    if (index < 0) {
        index = self.imgArr.count - 1;
    }
    
    if (index > self.imgArr.count - 1) {
        index = 0;
    }
    
    return self.imgArr[index];
}

- (UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] init];
        _scroll.pagingEnabled = YES;
        _scroll.delegate = self;
        _scroll.bounces = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
        for (UIGestureRecognizer *ges in _scroll.gestureRecognizers) {
            ges.cancelsTouchesInView = NO;
        }
    }
    return _scroll;
}

- (UIImageView *)getImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    return imageView;
}

- (UIImageView *)leftImg {
    if (!_leftImg) {
        _leftImg = [self getImageView];
        _leftImg.frame = CGRectMake(0, 0, scrollPageWidth, scrollPageHeight);
        _leftImg.backgroundColor = [UIColor blueColor];
    }
    return _leftImg;
}

- (UIImageView *)midImg {
    if (!_midImg) {
        _midImg = [self getImageView];
        _midImg.frame = CGRectMake(scrollPageWidth, 0, scrollPageWidth, scrollPageHeight);
        _midImg.backgroundColor = [UIColor redColor];
    }
    return _midImg;
}

- (UIImageView *)rightImg {
    if (!_rightImg) {
        _rightImg = [self getImageView];
        _rightImg.frame = CGRectMake(scrollPageWidth * 2, 0, scrollPageWidth, scrollPageHeight);
        _rightImg.backgroundColor = [UIColor greenColor];
    }
    return _rightImg;
}

- (NSArray *)imgArr {
    if (!_imgArr) {
        _imgArr = @[@"home_default1", @"home_default2"];
    }
    if (_imgArr.count <= 1) {
        self.scroll.scrollEnabled = NO;
    } else if (_imgArr.count > 1) {
        self.scroll.scrollEnabled = YES;
    }
    return _imgArr;
}
// 开始触摸时就会调用一次这个方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"摸我干啥！");
}
// 手指移动就会调用这个方法
// 这个方法调用非常频繁
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"哎呀，不要拽人家！");
    UITouch *touch = touches.anyObject;
    
    CGLog(@"%zd", touches.count);
}
// 手指离开屏幕时就会调用一次这个方法
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"手放开还能继续玩耍！");
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
