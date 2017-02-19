//
//  ViewController.m
//  WSwichDemo
//
//  Created by xiaowu on 2017/2/18.
//  Copyright © 2017年 WSAlone. All rights reserved.
//

#import "ViewController.h"
#import "WSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 自定义开关
    WSwitch * wswith = [[WSwitch alloc] initWithFrame:CGRectMake(60, 100, 20, 20)];
    
    // 一些颜色属性的设置
    wswith.tintColor = [UIColor redColor];
    wswith.onTintColor = [UIColor blueColor];
    wswith.thumbTintColor = [UIColor whiteColor];
    
    // 切换开关时的回调
    [wswith switchWillStartSwicth:^(BOOL isOn) {
        NSLog(@"swithWillStartSwith:%zd",isOn);
    }];
    
    [wswith switchDidEndSwitch:^(BOOL isOn) {
        NSLog(@"swithDidEndSwith:%zd",isOn);
    }];

    [self.view addSubview:wswith];
    
    // 系统开关
    UISwitch *swith = [[UISwitch alloc] initWithFrame:CGRectMake(160, 100, 20, 20)];
    [self.view addSubview:swith];
    
}

@end
