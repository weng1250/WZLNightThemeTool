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
static NSString *const KEY_PROPERTY_WZLNIGHT_TEXTCOLOR = @"KEY_PROPERTY_WZLNIGHT_TEXTCOLOR";
static NSString *const KEY_PROPERTY_WZLNIGHT_TINTCOLOR = @"KEY_PROPERTY_WZLNIGHT_TINTCOLOR";

@implementation UIView (WZLNightTheme)


#pragma mark - setter / getter

- (void)setWZLNightBackgroundColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &KEY_PROPERTY_WZLNIGHT_BACKGROUNDCOLOR, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)WZLNightBackgroundColor
{
    return objc_getAssociatedObject(self, &KEY_PROPERTY_WZLNIGHT_BACKGROUNDCOLOR);
}

- (void)setWZLNightTextColor:(UIColor *)WZLNightTextColor
{
    objc_setAssociatedObject(self, &KEY_PROPERTY_WZLNIGHT_TEXTCOLOR, WZLNightTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)WZLNightTextColor
{
    return objc_getAssociatedObject(self, &KEY_PROPERTY_WZLNIGHT_TEXTCOLOR);
}

- (void)setWZLNightTintColor:(UIColor *)WZLNightTintColor
{
    objc_setAssociatedObject(self, &KEY_PROPERTY_WZLNIGHT_TINTCOLOR, WZLNightTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)WZLNightTintColor
{
    return objc_getAssociatedObject(self, &KEY_PROPERTY_WZLNIGHT_TINTCOLOR);
}

@end
