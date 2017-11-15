//
//  CCPopView+Private.h
//  MangaHD
//
//  Created by xbwu on 16/12/22.
//  Copyright © 2016年 xbwu. All rights reserved.
//

#import "CCPopView.h"

@interface CCPopView (Private)

- (void)_hide;

- (void)show:(NSNumber*)animated;

+ (id)popForView:(UIView *)view;

@property (nonatomic, assign) int countRetain;
@property (nonatomic, strong) UIView *contentView;

@end
