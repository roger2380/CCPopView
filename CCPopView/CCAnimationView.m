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

@interface CCAnimationContentView : UIImageView

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CCAnimationContentView

- (UIImageView *)imageView {
  if (_imageView == nil) {
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.animationDuration = 1;
    _imageView.animationRepeatCount = 0;
    [self addSubview:_imageView];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (UIImage *image in [CCPopConfig animationImages]) {
      [array addObject:image];
    }
    _imageView.animationImages = array.copy;
  }
  return _imageView;
}

- (void)layoutSubviews {
  self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end

@interface CCAnimationView() {
  
}

@end

@implementation CCAnimationView

- (void)show:(NSNumber*)animated {
  [super show:animated];
  CCAnimationContentView *contentView = (CCAnimationContentView *)self.contentView;
  [contentView startAnimating];
}

- (void)_hide {
  [super _hide];
  CCAnimationContentView *contentView = (CCAnimationContentView *)self.contentView;
  [contentView stopAnimating];
}

- (CGSize)size {
  return [CCPopConfig animationSize];
}

- (void)showInView:(UIView *)view animated:(BOOL)animated {
  CCAnimationContentView *contentView = [[CCAnimationContentView alloc] init];
  self.contentView = contentView;
  [super showInView:view animated:animated];
}

@end
