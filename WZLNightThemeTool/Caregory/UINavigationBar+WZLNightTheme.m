//
//  UINavigationBar+WZLNightTheme.m
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/25.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import "UINavigationBar+WZLNightTheme.h"
#import <objc/runtime.h>
#import "WZLNightThemeManager.h"

static NSString *const KEY_PROPERTY_WZLNIGHT_BARTINTCOLOR = @"KEY_PROPERTY_WZLNIGHT_BARTINTCOLOR";
static NSString *const KEY_PROPERTY_WZLDAY_BARTINTCOLOR = @"KEY_PROPERTY_WZLDAY_BARTINTCOLOR";

@implementation UINavigationBar (WZLNightTheme)
@dynamic WZLDayBarTintColor,WZLNightBarTintColor;

- (void)setWZLDayBarTintColor:(UIColor *)WZLDayBarTintColor
{
    objc_setAssociatedObject(self, &KEY_PROPERTY_WZLDAY_BARTINTCOLOR, WZLDayBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [WZLNightThemeManager changeThemeColorRightNowIfNeedWithView:self propertyName:@"WZLDayBarTintColor"];
}

- (UIColor *)WZLDayBarTintColor
{
    return objc_getAssociatedObject(self, &KEY_PROPERTY_WZLDAY_BARTINTCOLOR);
}

- (void)setWZLNightBarTintColor:(UIColor *)WZLNightBarTintColor
{
    objc_setAssociatedObject(self, &KEY_PROPERTY_WZLNIGHT_BARTINTCOLOR, WZLNightBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [WZLNightThemeManager changeThemeColorRightNowIfNeedWithView:self propertyName:@"WZLNightBarTintColor"];
}

- (UIColor *)WZLNightBarTintColor
{
    return objc_getAssociatedObject(self, &KEY_PROPERTY_WZLNIGHT_BARTINTCOLOR);
}

@end
