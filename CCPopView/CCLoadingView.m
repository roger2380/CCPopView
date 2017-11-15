//
//  CCLoadingView.m
//  CCPopView
//
//  Created by xbwu on 17/6/10.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "CCLoadingView.h"
#import "CCPopView+Private.h"
#import "CCPopConfig.h"

@interface CCLoadingContentView : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation CCLoadingContentView

- (UILabel *)titleLabel {
  if (_titleLabel == nil) {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [CCPopConfig fontForTitle];
    [self addSubview:_titleLabel];
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

+ (CGSize)sizeForTitle:(NSString *)title {
  CGSize size = [title sizeWithFont:[CCPopConfig fontForTitle]
                  constrainedToSize:CGSizeMake(300, 10000)];
  return CGSizeMake(size.width + 30, size.height + 55);
}

- (void)layoutSubviews {
  CGSize size = [self.titleLabel.text sizeWithFont:self.titleLabel.font
                                 constrainedToSize:CGSizeMake(300, 10000)];
  if (size.height == 0 || size.width == 0)  {
    self.indicatorView.center = CGPointMake(self.frame.size.width/2.0,
                                            self.frame.size.height/2.0);
  } else {
    self.titleLabel.frame = CGRectMake(15, 40, size.width, size.height);
    self.indicatorView.center = CGPointMake(self.frame.size.width/2.0, 25);
  }
}

@end

@interface CCLoadingView () {
  
}

@property (nonatomic, strong) NSString *title;

@end

@implementation CCLoadingView

- (CGSize)sizeForContentOfPop:(CCPopView *)popView {
  return [CCLoadingContentView sizeForTitle:self.title];
}

- (UIView *)contentViewToPop:(CCPopView *)popView {
  CCLoadingContentView *contentView = [[CCLoadingContentView alloc] init];
  contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
  contentView.layer.cornerRadius = 5;
  contentView.clipsToBounds = YES;
  contentView.titleLabel.text = self.title;
  return contentView;
}

- (void)show:(NSNumber *)animated {
  [super show:animated];
  CCLoadingContentView *contentView = (CCLoadingContentView *)self.contentView;
  [contentView.indicatorView startAnimating];
}

- (void)_hide {
  [super _hide];
  CCLoadingContentView *contentView = (CCLoadingContentView *)self.contentView;
  [contentView.indicatorView stopAnimating];
}

@end
