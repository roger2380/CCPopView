//
//  CCAnimationView.m
//  CCPopView
//
//  Created by xbwu on 16/12/21.
//  Copyright © 2016年 xbwu. All rights reserved.
//

#import "CCAnimationView.h"
#import "CCPopConfig.h"
#import "CCPopView+Private.h"
#import "CCPopConfig.h"

@interface CCAnimationView() <CCPopViewContentDelegate> {
  
}

@end

@implementation CCAnimationView

+ (CCAnimationView *)showInView:(UIView *)view {
  CCAnimationView *popView = [self popForView:view];
  [popView showInView:view animated:NO delegate:popView];
  return popView;
}

+ (CCAnimationView *)showInViewWithAnimation:(UIView *)view {
  CCAnimationView *popView = [self popForView:view];
  [popView showInView:view animated:YES delegate:popView];
  return popView;
}

- (void)show:(NSNumber *)animated {
  [super show:animated];
  UIImageView *contentView = (UIImageView *)self.contentView;
  [contentView startAnimating];
}

- (void)_hide {
  [super _hide];
  UIImageView *contentView = (UIImageView *)self.contentView;
  [contentView stopAnimating];
}

- (CGSize)sizeForContentOfPop:(CCPopView *)popView {
  return [CCPopConfig animationSize];
}

- (UIView *)contentViewToPop:(CCPopView *)popView {
  UIImageView *contentView = [[UIImageView alloc] init];
  NSMutableArray *array = [[NSMutableArray alloc] init];
  for (UIImage *image in [CCPopConfig animationImages]) {
    [array addObject:image];
  }
  contentView.animationImages = array.copy;
  return contentView;
}

@end
