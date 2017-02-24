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
    self.alpha = 0;
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

+ (CCPopView *)showInView:(UIView *)view animated:(BOOL)animated {
  CCPopView *popView = [self popForView:view];
  [popView performSelector:@selector(show:) withObject:@(animated) afterDelay:0.1];
  return popView;
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
  [view addSubview:popView.maskView];
  [view addSubview:popView];
  if ([self retainEnable]) {
    popView.countRetain++;
  }
  [popView.layer removeAllAnimations];
  popView.transform = CGAffineTransformIdentity;
  [popView setNeedsLayout];
  return popView;
}

- (void)show:(NSNumber*)animated {
  if ([animated boolValue]) {
    self.alpha = 0.0f;
    self.transform = CGAffineTransformConcat(CGAffineTransformIdentity,
                                             CGAffineTransformMakeScale(0.3, 0.3));
    [UIView animateWithDuration:0.2
                     animations:^{
                       self.alpha = 1.0;
                       [self setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1)];
                     }
                     completion:^(BOOL finished) {
                       if (!finished) {
                         return ;
                       }
                       [UIView animateWithDuration:0.13
                                        animations:^{
                                          self.alpha = 1.0;
                                          [self setTransform:CGAffineTransformScale(CGAffineTransformIdentity,
                                                                                    0.9, 0.9)];
                                        }
                                        completion:^(BOOL finished) {
                                          if (!finished) {
                                            return ;
                                          }
                                          [UIView animateWithDuration:0.13
                                                           animations:^{
                                                             self.alpha = 1.0;
                                                             [self setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)];
                                                           }
                                                           completion:^(BOOL finished) {
                                                             
                                                           }];
                                        }];
                     }];
  }
  else {
    self.alpha = 1.0f;
  }
}

+ (void)hideFrom:(UIView *)view animated:(BOOL)animated afterDelay:(NSTimeInterval)delay {
  CCPopView *popView = objc_getAssociatedObject(view, (__bridge const void *)([self class]));
  if (popView) {
    [popView hide:NO afterDelay:delay];
  }
}

+ (void)hideFrom:(UIView *)view animated:(BOOL)animated {
  CCPopView *popView = objc_getAssociatedObject(view, (__bridge const void *)([self class]));
  if (popView) {
    [popView hide:NO];
  }
}

- (void)hide:(BOOL)animated {
  [self performSelector:@selector(hideDelayed:)
             withObject:@(NO)];
}

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay {
//  if (delay < 0.2 && animated) {
//    delay = 0.2;
//  }
  [self performSelector:@selector(hideDelayed:)
             withObject:@(NO)
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
  self.transform = CGAffineTransformIdentity;
  [self.layer removeAllAnimations];
  if (animated) {
    [UIView animateWithDuration:0.3
                     animations:^{
                       self.transform = CGAffineTransformConcat(CGAffineTransformIdentity,
                                                                CGAffineTransformMakeScale(0.5f, 0.5f));
                       self.alpha = 0.02f;
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
  self.alpha = 0.0f;
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
