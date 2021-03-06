//
//  UINavigationBar+WZLNightTheme.h
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/25.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (WZLNightTheme)

@property (nonatomic, strong) UIColor *WZLNightBarTintColor;

#pragma mark - internal
@property (nonatomic, strong) UIColor *WZLDayBarTintColor;

@end
