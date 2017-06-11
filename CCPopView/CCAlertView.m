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

@interface CCAlertView() {
  
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CCAlertView

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

+ (CCAlertView*)showInView:(UIView *)view title:(NSString *)string animated:(BOOL)animated {
  CCAlertView *alert = (CCAlertView *)[self popForView:view];
  alert.title = string;
  alert.layer.cornerRadius = 5;
  alert.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
  [alert show:@(animated)];
  return alert;
}

- (void)setTitle:(NSString *)title {
  self.titleLabel.text = title;
  CGSize size = [self.titleLabel.text sizeWithFont:self.titleLabel.font
                                 constrainedToSize:CGSizeMake(300, 10000)];
  self.frame = CGRectMake(0, 0, size.width + 30, size.height + 30);
  self.titleLabel.frame = CGRectMake(15, 15, size.width, size.height);
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

@end
