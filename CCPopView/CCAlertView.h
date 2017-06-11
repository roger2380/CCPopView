//
//  CCAlertView.h
//  CCPopView
//
//  Created by xbwu on 16/12/21.
//  Copyright © 2016年 xbwu. All rights reserved.
//

#import "CCPopView.h"

@interface CCAlertView : CCPopView

+ (CCAlertView *)showInView:(UIView *)view title:(NSString *)string animated:(BOOL)animated;

@end
