//
//  CCPopConfig.h
//  CCPopView
//
//  Created by xbwu on 13/11/2017.
//  Copyright © 2017 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CCPopConfig : NSObject

+ (void)setFontForTitle:(UIFont *)font;
+ (void)setAnimationSize:(CGSize)size;
+ (void)setAnimationImages:(NSArray *)images;

+ (UIFont *)fontForTitle;
+ (CGSize)animationSize;
+ (NSArray *)animationImages;

@end
