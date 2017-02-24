//
//  ViewController.m
//  CCPopView
//
//  Created by xbwu on 16/12/21.
//  Copyright © 2016年 xbwu. All rights reserved.
//

#import "ViewController.h"
#import "CCPopView.h"
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
  btn.frame = CGRectMake(100, 100, 50, 50);
  [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
  
  
  btn = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.view addSubview:btn];
  btn.frame = CGRectMake(100, 200, 50, 50);
  btn.backgroundColor = [UIColor greenColor];
  [btn addTarget:self action:@selector(show1) forControlEvents:UIControlEventTouchUpInside];
  
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)show {
  [CCAlertView showInView:self.view title:@"test--test\ntesteeee" animated:YES];
  [CCAlertView hideFrom:self.view animated:YES afterDelay:1];
}

- (void)show1 {
  [CCAnimationView showInView:self.view animated:YES];
  [CCAnimationView hideFrom:self.view animated:YES afterDelay:3];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
