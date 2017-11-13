//
//  CCPopView.h
//  CCPopView
//
//  Created by xbwu on 16/12/21.
//  Copyright © 2016年 xbwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCPopView : UIView {
  UIView *_maskView;
}

@property (nonatomic, strong) UIView *maskView;

//子类重载
+ (BOOL)retainEnable;

+ (CCPopView *)showInView:(UIView *)view;
+ (CCPopView *)showInViewWithAnimation:(UIView *)view;  //带动画
+ (void)hideFrom:(UIView *)view;
+ (void)hideWithAnimationFrom:(UIView *)view;

- (void)showInView:(UIView *)view animated:(BOOL)animated;
- (void)hide:(BOOL)animated;
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end
