//
//  CCAlertView.m
//  CCPopView
//
//  Created by xbwu on 16/12/21.
//  Copyright © 2016年 xbwu. All rights reserved.
//

#import "CCAlertView.h"
#import "CCPopConfig.h"
#import "CCPopView+Private.h"

@interface CCAlertContentView : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CCAlertContentView

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

+ (CGSize)sizeForTitle:(NSString *)title {
  if (title.length == 0) {
    return CGSizeMake(60, 30);
  }
  CGSize size = [title sizeWithFont:[CCPopConfig fontForTitle]
                  constrainedToSize:CGSizeMake(300, 10000)];
  return CGSizeMake(size.width + 30, size.height + 30);
}

- (void)layoutSubviews {
  CGSize size = [self.titleLabel.text sizeWithFont:self.titleLabel.font
                                 constrainedToSize:CGSizeMake(300, 10000)];
  self.titleLabel.frame = CGRectMake(15, 15, size.width, size.height);
}

@end

@interface CCAlertView() <CCPopViewContentDelegate> {
  
}

@property (nonatomic, strong) NSString *title;

@end

@implementation CCAlertView

+ (CCAlertView *)showInView:(UIView *)view {
  return [self showInView:view title:nil animated:NO];
}

+ (CCAlertView *)showInViewWithAnimation:(UIView *)view {
  return [self showInView:view title:nil animated:YES];
}

+ (CCAlertView *)showInView:(UIView *)view title:(NSString *)string {
  return [self showInView:view title:string animated:NO];
}

+ (CCAlertView *)showInViewWithAnimation:(UIView *)view title:(NSString *)string {
  return [self showInView:view title:string animated:YES];
}

+ (CCAlertView *)showInView:(UIView *)view title:(NSString *)string animated:(BOOL)animated {
  CCAlertView *popView = [self popForView:view];
  [popView showInView:view title:string animated:animated];
  return popView;
}

- (void)showInView:(UIView *)view title:(NSString *)string animated:(BOOL)animated {
  self.title = string;
  [super showInView:view animated:animated delegate:self];
}

- (CGSize)sizeForContentOfPop:(CCPopView *)popView {
  return [CCAlertContentView sizeForTitle:self.title];
}

- (UIView *)contentViewToPop:(CCPopView *)popView {
  CCAlertContentView *contentView = [[CCAlertContentView alloc] init];
  contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
  contentView.layer.cornerRadius = 5;
  contentView.clipsToBounds = YES;
  contentView.titleLabel.text = self.title;
  return contentView;
}

@end
