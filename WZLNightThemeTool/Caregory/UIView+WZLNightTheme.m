//
//  UIView+WZLNightTheme.m
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/23.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import "UIView+WZLNightTheme.h"
#import <objc/runtime.h>

static NSString *const KEY_PROPERTY_WZLNIGHT_BACKGROUNDCOLOR = @"KEY_PROPERTY_WZLNIGHT_BACKGROUNDCOLOR";
static NSString *const KEY_PROPERTY_WZLNIGHT_TINTCOLOR = @"KEY_PROPERTY_WZLNIGHT_TINTCOLOR";
static NSString *const KEY_PROPERTY_WZLDAY_BACKGROUNDCOLOR = @"KEY_PROPERTY_WZLDAY_BACKGROUNDCOLOR";
static NSString *const KEY_PROPERTY_WZLDAY_TINTCOLOR = @"KEY_PROPERTY_WZLDAY_TINTCOLOR";

@implementation UIView (WZLNightTheme)

@dynamic WZLDayBackgroundColor, WZLNightBackgroundColor, WZLNightTintColor;

#pragma mark - setter / getter

- (void)setWZLNightBackgroundColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &KEY_PROPERTY_WZLNIGHT_BACKGROUNDCOLOR, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)WZLNightBackgroundColor
{
    return objc_getAssociatedObject(self, &KEY_PROPERTY_WZLNIGHT_BACKGROUNDCOLOR);
}

- (void)setWZLNightTintColor:(UIColor *)WZLNightTintColor
{
    objc_setAssociatedObject(self, &KEY_PROPERTY_WZLNIGHT_TINTCOLOR, WZLNightTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)WZLNightTintColor
{
    return objc_getAssociatedObject(self, &KEY_PROPERTY_WZLNIGHT_TINTCOLOR);
}

- (void)setWZLDayBackgroundColor:(UIColor *)WZLDayBackgroundColor
{
    objc_setAssociatedObject(self, &KEY_PROPERTY_WZLDAY_BACKGROUNDCOLOR, WZLDayBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)WZLDayBackgroundColor
{
    return objc_getAssociatedObject(self, &KEY_PROPERTY_WZLDAY_BACKGROUNDCOLOR);
}

- (void)setWZLDayTintColor:(UIColor *)WZLDayTintColor
{
    objc_setAssociatedObject(self, &KEY_PROPERTY_WZLDAY_TINTCOLOR, WZLDayTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)WZLDayTintColor
{
    return objc_getAssociatedObject(self, &KEY_PROPERTY_WZLDAY_TINTCOLOR);
}


@end
