//
//  CCLoadingView.m
//  CCPopView
//
//  Created by xbwu on 17/6/10.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "CCLoadingView.h"
#import "CCPopView+Private.h"

@interface CCLoadingView () {
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation CCLoadingView

- (UILabel *)titleLabel {
  if (_titleLabel == nil) {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleLabel];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
#ifdef CCALERT_TITLE_FONT
    _titleLabel.font = CCALERT_TITLE_FONT;
#else
    _titleLabel.font = [UIFont systemFontOfSize:15];
#endif
  }
  return _titleLabel;
}

- (UIActivityIndicatorView *)indicatorView {
  if (_indicatorView == nil) {
    _indicatorView = [[UIActivityIndicatorView alloc] init];
    [self addSubview:_indicatorView];
  }
  return _indicatorView;
}

+ (CCLoadingView*)showInView:(UIView *)view title:(NSString *)string animated:(BOOL)animated {
  CCLoadingView *alert = (CCLoadingView *)[self popForView:view];
  alert.title = string;
  alert.layer.cornerRadius = 5;
  alert.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
  [alert show:@(animated)];
  return alert;
}

- (void)show:(NSNumber*)animated {
  [super show:animated];
  [self.indicatorView startAnimating];
}

- (void)_hide {
  [super _hide];
  [self.indicatorView stopAnimating];
}

- (void)setTitle:(NSString *)title {
  self.titleLabel.text = title;
  CGSize size = [self.titleLabel.text sizeWithFont:self.titleLabel.font
                                 constrainedToSize:CGSizeMake(300, 10000)];
  if (size.height == 0 || size.width == 0)  {
    self.frame = CGRectMake(0, 0, 50, 50);
    self.indicatorView.center = CGPointMake(self.frame.size.width/2.0,
                                            self.frame.size.height/2.0);
  }
  else {
    self.frame = CGRectMake(0, 0, size.width + 30, size.height + 55);
    self.titleLabel.frame = CGRectMake(15, 40, size.width, size.height);
    self.indicatorView.center = CGPointMake(self.frame.size.width/2.0, 25);
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

@end
