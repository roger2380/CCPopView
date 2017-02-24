//
//  UIView+CCPopView.m
//  CCPopView
//
//  Created by xbwu on 16/12/21.
//  Copyright © 2016年 xbwu. All rights reserved.
//

#import "UIView+CCPopView.h"
#import <objc/runtime.h>

static char kPopViewKey;

@implementation UIView (CCPopView)

- (CCPopView *)popView {
  CCPopView *popView = objc_getAssociatedObject(self, &kPopViewKey);
  return popView;
}

- (void)setPopView:(CCPopView *)popView {
  objc_setAssociatedObject(self, &kPopViewKey, popView, OBJC_ASSOCIATION_RETAIN);
}

@end
