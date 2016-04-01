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

#define WZLNightThemeToolSupportedColorProperties_UIView (@[@"WZLNightBackgroundColor", @"WZLDayBackgroundColor", @"WZLNightTintColor", @"WZLDayTintColor"])
#define WZLNightThemeToolSupportedColorProperties_UILabel (@[@"WZLNightTextColor", @"WZLDayTextColor"])
#define WZLNightThemeToolSupportedColorProperties_UINavigationBar (@[@"WZLNightBarTintColor", @"WZLDayBarTintColor"])

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
    [WZLNightThemeTool registerWithView:self propertyName:@"WZLNightBackgroundColor" forNightColor:YES];
    [self swizzle_setWZLNightBackgroundColor:color];
}

- (void)swizzle_setWZLDayBackgroundColor:(UIColor *)color
{
    [WZLNightThemeTool registerWithView:self propertyName:@"WZLDayBackgroundColor" forNightColor:NO];
    [self swizzle_setWZLDayBackgroundColor:color];
}

- (void)swizzle_setWZLNightTintColor:(UIColor *)color
{
    [WZLNightThemeTool registerWithView:self propertyName:@"WZLNightTintColor" forNightColor:YES];
    [self swizzle_setWZLNightTintColor:color];
}

- (void)swizzle_setWZLDayTintColor:(UIColor *)color
{
    [WZLNightThemeTool registerWithView:self propertyName:@"WZLDayTintColor" forNightColor:NO];
    [self swizzle_setWZLDayTintColor:color];
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
    [WZLNightThemeTool registerWithView:self propertyName:@"WZLNightTextColor" forNightColor:YES];
    [self swizzle_setWZLNightTextColor:color];
}

- (void)swizzle_setWZLDayTextColor:(UIColor *)color
{
    [WZLNightThemeTool registerWithView:self propertyName:@"WZLDayTextColor" forNightColor:NO];
    [self swizzle_setWZLDayTextColor:color];
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
    [WZLNightThemeTool registerWithView:self propertyName:@"WZLNightBarTintColor" forNightColor:YES];
    [self swizzle_setWZLNightBarTintColor:color];
}

- (void)swizzle_setWZLDayBarTintColor:(UIColor *)color
{
    [WZLNightThemeTool registerWithView:self propertyName:@"WZLDayBarTintColor" forNightColor:NO];
    [self swizzle_setWZLDayBarTintColor:color];
}

@end