//
//  UIView+WZLNightTheme.h
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/23.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WZLNightTheme)

@property (nonatomic, strong) UIColor *WZLNightBackgroundColor;

@property (nonatomic, strong) UIColor *WZLNightTintColor;


#pragma mark - internal
@property (nonatomic, strong) UIColor *WZLDayBackgroundColor;

@property (nonatomic, strong) UIColor *WZLDayTintColor;

@end
