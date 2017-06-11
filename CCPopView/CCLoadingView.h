//
//  CCLoadingView.h
//  CCPopView
//
//  Created by xbwu on 17/6/10.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "CCPopView.h"

@interface CCLoadingView : CCPopView

+ (CCLoadingView *)showInView:(UIView *)view title:(NSString *)string animated:(BOOL)animated;

@end
