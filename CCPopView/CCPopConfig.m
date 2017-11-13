//
//  CCPopConfig.m
//  CCPopView
//
//  Created by xbwu on 13/11/2017.
//  Copyright © 2017 xbwu. All rights reserved.
//

#import "CCPopConfig.h"

@implementation CCPopConfig

static UIFont *sFontForTitle = nil;
static CGSize sAnimationSize;
static NSArray *sAnimationImages = nil;

+ (void)setFontForTitle:(UIFont *)font {
  sFontForTitle = font;
}

+ (void)setAnimationSize:(CGSize)size {
  sAnimationSize = size;
}

+ (UIFont *)fontForTitle {
  if (sFontForTitle == nil) {
    return [UIFont systemFontOfSize:15];
  }
  return sFontForTitle;
}

+ (CGSize)animationSize {
  if (CGSizeEqualToSize(sAnimationSize, CGSizeZero) ) {
    return CGSizeMake(100, 100);
  }
  return sAnimationSize;
}

+ (NSArray *)animationImages {
  return sAnimationImages;
}

+ (void)setAnimationImages:(NSArray *)images {
  sAnimationImages = images;
}

@end

