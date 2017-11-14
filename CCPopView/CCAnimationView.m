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

@interface CCAnimationView() {
  
}

@end

@implementation CCAnimationView

- (void)show:(NSNumber*)animated {
  [super show:animated];
  UIImageView *contentView = (UIImageView *)self.contentView;
  [contentView startAnimating];
}

- (void)_hide {
  [super _hide];
  UIImageView *contentView = (UIImageView *)self.contentView;
  [contentView stopAnimating];
}

- (CGSize)size {
  return [CCPopConfig animationSize];
}

- (void)showInView:(UIView *)view animated:(BOOL)animated {
  UIImageView *contentView = [[UIImageView alloc] init];
  self.contentView = contentView;
  NSMutableArray *array = [[NSMutableArray alloc] init];
  for (UIImage *image in [CCPopConfig animationImages]) {
    [array addObject:image];
  }
  contentView.animationImages = array.copy;
  [super showInView:view animated:animated];
}

@end
