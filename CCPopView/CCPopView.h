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

+ (id)popForView:(UIView *)view;

//子类重载
+ (BOOL)retainEnable;

+ (CCPopView *)showInView:(UIView *)view animated:(BOOL)animated;

+ (void)hideFrom:(UIView *)view animated:(BOOL)animated afterDelay:(NSTimeInterval)delay;
+ (void)hideFrom:(UIView *)view animated:(BOOL)animated;

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;
- (void)hide:(BOOL)animated;


@end
