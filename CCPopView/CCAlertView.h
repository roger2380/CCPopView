//
//  CCAlertView.h
//  CCPopView
//
//  Created by xbwu on 16/12/21.
//  Copyright © 2016年 xbwu. All rights reserved.
//

#import "CCPopView.h"

@interface CCAlertView : CCPopView

+ (CCPopView *)showInView:(UIView *)view;
+ (CCPopView *)showInViewWithAnimation:(UIView *)view;

+ (CCPopView *)showInView:(UIView *)view title:(NSString *)string;
+ (CCPopView *)showInViewWithAnimation:(UIView *)view title:(NSString *)string;

@end
