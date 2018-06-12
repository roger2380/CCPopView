//
//  ViewController.m
//  CCPopView
//
//  Created by xbwu on 16/12/21.
//  Copyright © 2016年 xbwu. All rights reserved.
//

#import "ViewController.h"
#import "CCLoadingView.h"
#import "CCAlertView.h"
#import "CCAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.view addSubview:btn];
  btn.backgroundColor = [UIColor redColor];
  btn.frame = CGRectMake(100, 100, 100, 100);
  [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
  
  
  btn = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.view addSubview:btn];
  btn.frame = CGRectMake(100, 400, 100, 100);
  btn.backgroundColor = [UIColor greenColor];
  [btn addTarget:self action:@selector(show1) forControlEvents:UIControlEventTouchUpInside];
  
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)show {
  [[CCAlertView showInViewWithAnimation:self.view title:@""] hide:YES afterDelay:2];
}

- (void)show1 {
  [CCLoadingView showInViewWithAnimation:self.view title:@"我的 的 的的的的\ntesteeeetest--test\ntesteee"];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end

