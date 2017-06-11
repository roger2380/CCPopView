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

@interface CCAnimationView() {
  
}

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CCAnimationView

- (void)show:(NSNumber*)animated {
  [super show:animated];
  [self.imageView startAnimating];
}

- (void)_hide {
  [super _hide];
  [self.imageView stopAnimating];
}

+ (CCAnimationView *)showInView:(UIView *)view animated:(BOOL)animated {
  CCAnimationView *popView = [self popForView:view];
#ifdef CCANIMATION_SIZE
  popView.frame = CGRectMake(0, 0, CCANIMATION_SIZE.width, CCANIMATION_SIZE.height);
#else
  popView.frame = CGRectMake(0, 0, 100, 100);
#endif
  [popView show:@(animated)];
  return popView;
}

- (UIImageView *)imageView {
  if (_imageView == nil) {
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.animationDuration = 1;
    _imageView.animationRepeatCount = 0;
    [self addSubview:_imageView];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 30; i++) {
      NSString *imageName = [NSString stringWithFormat:@"loading-%d", 1 + i];
      [array addObject:[UIImage imageNamed:imageName]];
    }
    _imageView.animationImages = array;
  }
  return _imageView;
}

- (void)layoutSubviews {
  self.imageView.frame = CGRectMake(0, 0,
                                    self.frame.size.width,
                                    self.frame.size.height);
  [super layoutSubviews];
}

@end
