//
//  CCLoadingView.h
//  CCPopView
//
//  Created by xbwu on 17/6/10.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "CCPopView.h"

@interface CCLoadingView : CCPopView

+ (CCPopView *)showInView:(UIView *)view title:(NSString *)string;
+ (CCPopView *)showInViewWithAnimation:(UIView *)view title:(NSString *)string;

@end
