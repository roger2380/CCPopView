//
//  CCPopView.m
//  CCPopView
//
//  Created by xbwu on 16/12/21.
//  Copyright © 2016年 xbwu. All rights reserved.
//

#import "CCPopView.h"
#import <objc/runtime.h>

@interface CCPopView()  {
}

@property (nonatomic, assign) int countRetain;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation CCPopView

@synthesize maskView = _maskView;


- (id)init {
  self = [super init];
  if (self) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarOrientationChange)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
  }
  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.autoresizingMask =  UIViewAutoresizingFlexibleTopMargin
                           | UIViewAutoresizingFlexibleBottomMargin
                           | UIViewAutoresizingFlexibleLeftMargin
                           | UIViewAutoresizingFlexibleRightMargin;
  }
  return self;
}

+ (BOOL)retainEnable {
  return YES;
}

- (void)setContentView:(UIView *)contentView {
  [_contentView removeFromSuperview];
  _contentView = contentView;
}

+ (CCPopView *)showInView:(UIView *)view delegate:(id<CCPopViewContentDelegate>)delegate {
  return [self showInView:view animated:NO delegate:delegate];
}

+ (CCPopView *)showInViewWithAnimation:(UIView *)view delegate:(id<CCPopViewContentDelegate>)delegate {
  return [self showInView:view animated:YES delegate:delegate];
}

+ (CCPopView *)showInView:(UIView *)view animated:(BOOL)animated delegate:(id<CCPopViewContentDelegate>)delegate {
  CCPopView *popView = [self popForView:view];
  [popView showInView:view animated:animated delegate:delegate];
  return popView;
}

- (void)showInView:(UIView *)view animated:(BOOL)animated delegate:(id<CCPopViewContentDelegate>)delegate {
  [view addSubview:self.maskView];
  [view addSubview:self];
  self.contentView = [delegate contentViewToPop:self];
  self.contentView.alpha = 0;
  [self addSubview:self.contentView];
  if ([[self class] retainEnable]) {
    self.countRetain++;
  }
  CGSize size = [delegate sizeForContentOfPop:self];
  self.frame = CGRectMake(0, 0, size.width * 1.1, size.height * 1.1);
  self.contentView.frame = CGRectMake(0.05 * size.width, 0.05 * size.height, size.width, size.height);
  [self setNeedsLayout];
  [self.contentView setNeedsLayout];
  [self.contentView layoutIfNeeded];
  [self performSelector:@selector(show:) withObject:@(animated) afterDelay:0.1];
}

+ (id)popForView:(UIView *)view {
  if (view == nil) {
    return nil;
  }
  CCPopView *popView = nil;
  popView = objc_getAssociatedObject(view, (__bridge const void *)([self class]));
  if (popView == nil) {
    popView = [[[self class] alloc] init];
    objc_setAssociatedObject(view, (__bridge const void *)([self class]), popView, OBJC_ASSOCIATION_RETAIN);
  }
  return popView;
}

- (void)show:(NSNumber *)animated {
  if ([animated boolValue]) {
    self.contentView.alpha = 0.0f;
    self.contentView.transform = CGAffineTransformConcat(CGAffineTransformIdentity,
                                                         CGAffineTransformMakeScale(0.3, 0.3));
    [UIView animateWithDuration:0.2
                     animations:^{
                       self.contentView.alpha = 1.0;
                       [self.contentView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1)];
                     }
                     completion:^(BOOL finished) {
                       if (!finished) {
                         return ;
                       }
                       [UIView animateWithDuration:0.13
                                        animations:^{
                                          self.contentView.alpha = 1.0;
                                          [self.contentView setTransform:CGAffineTransformScale(CGAffineTransformIdentity,
                                                                                    0.9, 0.9)];
                                        }
                                        completion:^(BOOL finished) {
                                          if (!finished) {
                                            return ;
                                          }
                                          [UIView animateWithDuration:0.13
                                                           animations:^{
                                                             self.contentView.alpha = 1.0;
                                                             [self.contentView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)];
                                                           }
                                                           completion:^(BOOL finished) {
                                                             
                                                           }];
                                        }];
                     }];
  }
  else {
    self.contentView.alpha = 1.0f;
  }
}

+ (void)hideFrom:(UIView *)view {
  CCPopView *popView = objc_getAssociatedObject(view, (__bridge const void *)([self class]));
  if (popView) {
    [popView hide:NO];
  }
}

+ (void)hideWithAnimationFrom:(UIView *)view {
  CCPopView *popView = objc_getAssociatedObject(view, (__bridge const void *)([self class]));
  if (popView) {
    [popView hide:YES];
  }
}

- (void)hide:(BOOL)animated {
  [self performSelector:@selector(hideDelayed:)
             withObject:@(animated)];
}

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay {
  [self performSelector:@selector(hideDelayed:)
             withObject:@(animated)
             afterDelay:delay];
}

- (void)hideDelayed:(NSNumber *)animated {
  [self shouldHide:[animated boolValue]];
}

#pragma mark - 私有方法
- (void)shouldHide:(BOOL)animated {
  if ([[self class] retainEnable]) {
    _countRetain--;
    if (_countRetain > 0) {
      return;
    }
    _countRetain = 0;
  }
  [self.contentView.layer removeAllAnimations];
  self.contentView.transform = CGAffineTransformIdentity;
  if (animated) {
    [UIView animateWithDuration:0.3
                     animations:^{
                       self.contentView.transform = CGAffineTransformConcat(CGAffineTransformIdentity,
                                                                            CGAffineTransformMakeScale(0.5f, 0.5f));
                       self.contentView.alpha = 0.2f;
                       self.maskView.alpha = 0.2;
                     }
                     completion:^(BOOL finished) {
                       [self _hide];
                     }];
  }
  else {
    [self _hide];
  }
}

- (void)_hide {
  [self.contentView removeFromSuperview];
  [self.maskView removeFromSuperview];
  [self removeFromSuperview];
}

- (void)layoutSubviews {
  self.center = CGPointMake(self.superview.frame.size.width/2,
                            self.superview.frame.size.height/2);
  if (_maskView != nil) {
    _maskView.frame = CGRectMake(0, 0, self.superview.frame.size.width,
                                 self.superview.frame.size.height);
  }
  [self.superview bringSubviewToFront:self];
}

- (void)statusBarOrientationChange {
  [self setNeedsLayout];
}

@end
