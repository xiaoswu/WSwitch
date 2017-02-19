//
//  WSwitch.m
//  WSwichDemo
//
//  Created by xiaowu on 2017/2/18.
//  Copyright © 2017年 WSAlone. All rights reserved.
//

#import "WSwitch.h"

@interface WSwitch ()

@property (nonatomic,strong) UIView *onView;

@property (nonatomic,strong) UIView  *offView;

@property (nonatomic,strong) UIView *thumbView;

@property (nonatomic, assign) BOOL isOn;

@end

@implementation WSwitch
{
    CGPoint _swithOrgin;
    void(^_startBlock)(BOOL isOn);
    void(^_endBlock)(BOOL isOn);
}

#pragma mark -- 一些常量

static float const swichHeight = 30;
static float const swichWidth = 50;
static float const thumbViewMargin = 2;
static float const swichAnimatedDuration = 0.6;



#pragma mark -- 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _swithOrgin = frame.origin;
        
        [self initialize];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self initialize];
    }
    
    return self;
}

- (void)initialize{
    
    self.frame = CGRectMake(_swithOrgin.x, _swithOrgin.y, swichWidth, swichHeight);
    
    // 切圆角
    self.layer.cornerRadius = swichHeight * 0.5;
    self.layer.masksToBounds = YES;
    
    // 添加点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swith)];
    [self addGestureRecognizer:tapGesture];
    
    // 添加视图
    self.onView = ({
        UIView *onView = [[UIView alloc] init];
        onView.frame = CGRectMake(0, 0, swichWidth, swichHeight);
        onView.backgroundColor = [UIColor yellowColor];
        [self addSubview:onView];
        onView;
    });
    
    self.offView = ({
        UIView *offView = [[UIView alloc] init];
        offView.frame = CGRectMake(0, 0, swichWidth, swichHeight);
        offView.backgroundColor = [UIColor blackColor];
        [self addSubview:offView];
        offView;
    });
    
    self.thumbView = ({
        UIView *thumbView = [[UIView alloc] init];
        thumbView.frame = CGRectMake( thumbViewMargin, thumbViewMargin, swichHeight - thumbViewMargin*2, swichHeight - thumbViewMargin*2);
        thumbView.backgroundColor = [UIColor blueColor];
        thumbView.layer.cornerRadius = (swichHeight - thumbViewMargin*2) *0.5;
        [self addSubview:thumbView];
        thumbView;
    });

}

#pragma mark -- 点击事件及动画实现

- (void)swith{
    
    if (_startBlock) {
        _startBlock(self.isOn);
    }
    
    // 实现动画 分两步.
        [UIView animateWithDuration:swichAnimatedDuration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            CGRect thumbViewOrigin = self.thumbView.frame;
            if (self.isOn) {
                thumbViewOrigin.origin.x = thumbViewMargin;
            }
            else {
                thumbViewOrigin.origin.x = swichWidth - thumbViewMargin - self.thumbView.frame.size.width;
            }
            self.thumbView.frame = thumbViewOrigin;
            
        } completion:nil];
    
    UIView *animatedView;
    if (self.isOn) {
        animatedView = self.onView;
    }
    else {
        animatedView = self.offView;
    }
    UIColor * animatedcolor = animatedView.backgroundColor;
    
    [UIView animateWithDuration:swichAnimatedDuration animations:^{
            
        animatedView.backgroundColor = [UIColor clearColor];
            
        } completion:^(BOOL finished) {
            
           [self insertSubview:animatedView atIndex:0];
            animatedView.backgroundColor = animatedcolor;
            
            self.isOn = !self.isOn;
            
            if (_endBlock) {
                _endBlock(self.isOn);
            }
        }];
}

#pragma mark -- 开关回调

- (void)switchDidEndSwitch:(void (^)(BOOL))endBlock{
    
    _endBlock = endBlock;
}

- (void)switchWillStartSwicth:(void (^)(BOOL))startBlock{
    
    _startBlock = startBlock;
}

#pragma mark -- 属性设置

- (void)setTintColor:(UIColor *)tintColor{
    
    self.offView.backgroundColor = tintColor;
}

- (void)setOnTintColor:(UIColor *)onTintColor{
    
    self.onView.backgroundColor = onTintColor;
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor{
    
    self.thumbView.backgroundColor = thumbTintColor;
}

@end
