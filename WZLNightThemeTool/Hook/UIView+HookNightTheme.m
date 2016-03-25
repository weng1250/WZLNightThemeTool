//
//  UIView+HookNightTheme.m
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/23.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import "UIView+HookNightTheme.h"
#import <objc/runtime.h>
#import "WZLNightCategoryImport.h"
#import "NSObject+HookUtility.h"
#import "WZLNightThemeTool.h"
#import "WZLNightDebug.h"

#define WZLNightThemeToolSupportedColorProperties_UIView (@[@"WZLNightBackgroundColor", @"WZLNightTintColor"])
#define WZLNightThemeToolSupportedColorProperties_UILabel (@[@"WZLNightTextColor"])
#define WZLNightThemeToolSupportedColorProperties_UINavigationBar (@[@"WZLNightBarTintColor"])

@implementation UIView (HookNightTheme)

+ (void)load
{
    [UIView swizzleSelectorsWithWZLNightSupportedColorsProperty:WZLNightThemeToolSupportedColorProperties_UIView
                                                          class:[self class]];
}

#pragma mark - swizzle method to be injected
//method name MUST be 'swizzle_setXXXX'. Please refer to 'swizzleSelectorsWithWZLNightSupportedColorsProperty:'
- (void)swizzle_setWZLNightBackgroundColor:(UIColor *)color
{
    //inject your code here
    [WZLNightThemeTool registerNightWithView:self propertyName:@"WZLNightBackgroundColor"];
    [self swizzle_setWZLNightBackgroundColor:color];
}

- (void)swizzle_setWZLNightTintColor:(UIColor *)color
{
    [WZLNightThemeTool registerNightWithView:self propertyName:@"WZLNightTintColor"];
    [self swizzle_setWZLNightTintColor:color];
}

@end

@implementation UILabel (HookNightTheme)

+ (void)load
{
    [UIView swizzleSelectorsWithWZLNightSupportedColorsProperty:WZLNightThemeToolSupportedColorProperties_UILabel
                                                          class:[self class]];
}

//method name MUST be 'swizzle_setXXXX'. Please refer to 'swizzleSelectorsWithWZLNightSupportedColorsProperty:'
- (void)swizzle_setWZLNightTextColor:(UIColor *)color
{
    [WZLNightThemeTool registerNightWithView:self propertyName:@"WZLNightTextColor"];
    [self swizzle_setWZLNightTextColor:color];
}

@end

@implementation UINavigationBar (HookNightTheme)

+ (void)load
{
    [UIView swizzleSelectorsWithWZLNightSupportedColorsProperty:WZLNightThemeToolSupportedColorProperties_UINavigationBar
                                                          class:[self class]];
}

- (void)swizzle_setWZLNightBarTintColor:(UIColor *)color
{
    [WZLNightThemeTool registerNightWithView:self propertyName:@"WZLNightBarTintColor"];
    [self swizzle_setWZLNightBarTintColor:color];
}

@end