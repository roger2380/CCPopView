//
//  CCAnimationView.h
//  CCPopView
//
//  Created by xbwu on 16/12/21.
//  Copyright © 2016年 xbwu. All rights reserved.
//

#import "CCPopView.h"

@interface CCAnimationView : CCPopView

+ (CCPopView *)showInView:(UIView *)view;
+ (CCPopView *)showInViewWithAnimation:(UIView *)view;

@end
