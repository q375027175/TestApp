//
//  CGWaterWaveView.m
//  testApp
//
//  Created by 崔关 on 2018/4/24.
//  Copyright © 2018年 juge. All rights reserved.
//

#import "CGWaterWaveView.h"

@interface CGWaterWaveView()
//CADisplayLink是一个和屏幕刷新率同步定时器类
@property (nonatomic, strong) CADisplayLink *displayLink;

//waveLayer用来绘制波形曲线，并作为gradientLayer的mask，
@property (nonatomic, strong) CAShapeLayer *waveLayer;

//gradientLayer用来呈现背景的渐变色，若不需要渐变色，可以只用waveLayer来实现效果
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

//colors为渐变色需要用到的颜色数组
@property (nonatomic, strong) NSArray *colors;

//percent为整个小球的进度比例
@property (nonatomic, assign) CGFloat percent;


//绘制波形的变量定义，使用波形曲线y=Asin(ωx+φ)+k进行绘制
//waveAmplitude，波纹振幅，A
@property (nonatomic, assign) CGFloat waveAmplitude;

//waveCycle波纹周期，T = 2π/ω
@property (nonatomic, assign) CGFloat waveCycle;

//offsetX，波浪x位移，φ
@property (nonatomic, assign) CGFloat offsetX;

//currentWavePointY，当前波浪高度，k
@property (nonatomic, assign) CGFloat currentWavePointY;

//waveSpeed波纹速度，用来累加到相位φ上，达到波纹水平移动的效果
@property (nonatomic, assign) CGFloat waveSpeed;

//waveGrowth波纹上升速度，累加到k上，达到波浪高度上升的效果
@property (nonatomic, assign) CGFloat waveGrowth;

@property (nonatomic, assign) BOOL bWaveFinished;

@property (nonatomic, assign) BOOL increase;

@property (nonatomic, assign) CGFloat variable;
@end

@implementation CGWaterWaveView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.borderColor = [UIColor colorWithRed:164 / 255.0 green:216 / 255.0 blue:222 / 255.0 alpha:1].CGColor;
        self.layer.borderWidth = 1;
//        [self defaultConfig];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
    [self defaultConfig];
}

// 初始化属性
- (void)defaultConfig {
    //waveCycle的值影响波长
    self.waveCycle = 1.66 * M_PI / CGRectGetWidth(self.frame);
    self.currentWavePointY = CGRectGetHeight(self.frame);
    
    //waveGrowth为水波上升的速度
    self.waveGrowth = 1.0;
    
    //waveSpeed为水波波动的速度
    self.waveSpeed = 0.4 / M_PI;
    
    //currentWavePointY设为视图高度以保证水波从最低处开始上升
    self.offsetX = 0;
}

- (void)resetProperty {
    self.currentWavePointY = CGRectGetHeight(self.frame);
    self.offsetX = 0;
    
    // variable和increase的值影响水波的高度，
    self.variable = 1.6;
    self.increase = NO;
}

- (void)resetLayer {
    //设置gradientLayer的frame值并添加到当前类的layer上
    if (self.waveLayer) {
        [self.waveLayer removeFromSuperlayer];
        self.waveLayer = nil;
    }
    self.waveLayer = [CAShapeLayer layer];
    
    if (self.gradientLayer) {
        [self.gradientLayer removeFromSuperlayer];
        self.gradientLayer = nil;
    }
    
    self.gradientLayer = [CAGradientLayer layer];
    
    //设置gradientLayer的frame值并添加到当前类的layer上
    self.gradientLayer.frame = [self getGradientFrame];
    
    //设置渐变色相关的一些属性
    [self setGradientColor];
    
    //gradientLayer将waveLayer设为mask作为呈现波形效果的图层
    [self.gradientLayer setMask:self.waveLayer];
    
    [self.layer addSublayer:self.gradientLayer];
}

- (CGRect)getGradientFrame {
    // 加上20保证gradientLayer高度比waveLayer达到波峰时高度要高
    CGFloat gradientLayerHeight = CGRectGetHeight(self.frame) * self.percent + 20;
    
    if (gradientLayerHeight > CGRectGetHeight(self.frame)) {
        gradientLayerHeight = CGRectGetHeight(self.frame);
    }
    
//    gradientLayer在上升完成之后的frame值，如果gradientLayer在水波上升过程中不断变化frame值，将会导致一开始绘制前有几秒钟明显的卡顿，所以gradientLayer的frame只进行一次赋值
    CGRect frame = CGRectMake(0, CGRectGetHeight(self.frame) - gradientLayerHeight, CGRectGetWidth(self.frame), gradientLayerHeight);
    
    return frame;
}

- (void)setCurrentWave:(CADisplayLink *)displayLink {
    //displayLink在屏幕刷新过程中不断调用的方法，若水波上升到指定位置，则波动渐渐平缓并最终静止；若未到达指定位置，则继续上升。

    if ([self waveFinished]) {
        self.bWaveFinished = YES;
        
        //amplitudeReduce函数在上升完成后开始不断减小波形振幅，当振幅减小为0时，水波动画效果停止，此时将displayLink取消。
        [self amplitudeReduce];
        
        if (self.waveAmplitude <= 0) {
            [self stopWave];
            return;
        }
    } else {
        //amplitudeChanged函数在一定范围内轻微调整波形振幅，使得水波波动效果更真实，不断改变currentWavePointY的值，使得水波上升。
        

        [self amplitudeChanged];
        self.currentWavePointY -= self.waveGrowth;
    }
    
    self.offsetX += self.waveSpeed;
    
    //setCurrentWaveLayerPath函数用来绘制波形曲线
    [self setCurrentWaveLayerPath];
}

- (BOOL)waveFinished {
    //函数判断水波上升是否已完成
    return self.currentWavePointY <= (CGRectGetHeight(self.frame) * (1 - self.percent));
}

- (void)setCurrentWaveLayerPath {
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = self.currentWavePointY;
    CGFloat width = CGRectGetWidth(self.frame);

    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <= width; x ++) {
        // 正弦曲线公式
        y = self.waveAmplitude * sin(self.waveCycle * x + self.offsetX) + self.currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, width, CGRectGetHeight(self.frame));
    CGPathAddLineToPoint(path, nil, 0, CGRectGetHeight(self.frame));
    CGPathCloseSubpath(path);

    self.waveLayer.path = path;
    CGPathRelease(path);
}

- (void)amplitudeChanged {
    //振幅在一定范围内做增大减小的循环变化，变化范围可设置，variable的值决定振幅的大小。
    if (self.increase) {
        self.variable += 0.01;
    } else {
        self.variable -= 0.01;
    }
    // 变化的范围
    if (self.variable <= 1) {
        self.increase = YES;
    }
    
    if (self.variable >= 1.6) {
        self.increase = NO;
    }
    
    self.waveAmplitude = self.variable * 5;
}

- (void)amplitudeReduce {
    self.waveAmplitude -= 0.066;
}

- (void)stopWave {
    [self startWaveToPercent:1.0];
    return;
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)setGradientColor {
    self.gradientLayer.colors = self.colors;
    NSInteger count = self.colors.count;
    CGFloat d = 1.0 / count;
    NSMutableArray *locations = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i ++) {
        NSNumber *num = @(d + d * i);
        [locations addObject:num];
    }
    
    NSNumber *lastNum = @(1.0f);
    [locations addObject:lastNum];
    
    self.gradientLayer.locations = [locations copy];
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
}

- (void)startWaveToPercent:(CGFloat)percent {
    //percent为进度比例参数
    self.percent = percent;
    
    //resetProperty方法在动画开始前重置一些属性
    [self resetProperty];
    
    //resetLayer重置waveLayer和gradientLayer并做一些相关的设置
    [self resetLayer];
    
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
    
    self.bWaveFinished = NO;
    
    //displayLink启动同步渲染绘制波纹，绘制波纹的函数为setCurrentWave:
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setCurrentWave:)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (NSArray *)colors {
    if (!_colors) {
        UIColor *color0 = [UIColor colorWithRed:164 / 255.0 green:216 / 255.0 blue:222 / 255.0 alpha:1];
        UIColor *color1 = [UIColor colorWithRed:105 / 255.0 green:192 / 255.0 blue:154 / 255.0 alpha:1];
        
        _colors = @[(__bridge id)color0.CGColor, (__bridge id)color1.CGColor];
    }
    return _colors;
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self.displayLink invalidate];
    self.displayLink = nil;
}

@end
