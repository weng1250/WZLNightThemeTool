//
//  UILabel+WZLNightTheme.m
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/25.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import "UILabel+WZLNightTheme.h"
#import <objc/runtime.h>
#import "WZLNightThemeTool.h"

static NSString *const KEY_PROPERTY_WZLNIGHT_TEXTCOLOR = @"KEY_PROPERTY_WZLNIGHT_TEXTCOLOR";
static NSString *const KEY_PROPERTY_WZLDAY_TEXTCOLOR = @"KEY_PROPERTY_WZLDAY_TEXTCOLOR";

@implementation UILabel (WZLNightTheme)
@dynamic WZLNightTextColor, WZLDayTextColor;

- (void)setWZLNightTextColor:(UIColor *)WZLNightTextColor
{
    objc_setAssociatedObject(self, &KEY_PROPERTY_WZLNIGHT_TEXTCOLOR, WZLNightTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [WZLNightThemeTool changeThemeColorRightNowIfNeedWithView:self propertyName:@"WZLNightTextColor"];
}

- (UIColor *)WZLNightTextColor
{
    return objc_getAssociatedObject(self, &KEY_PROPERTY_WZLNIGHT_TEXTCOLOR);
}

- (void)setWZLDayTextColor:(UIColor *)WZLDayTextColor
{
    objc_setAssociatedObject(self, &KEY_PROPERTY_WZLDAY_TEXTCOLOR, WZLDayTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [WZLNightThemeTool changeThemeColorRightNowIfNeedWithView:self propertyName:@"WZLDayTextColor"];
}

- (UIColor *)WZLDayTextColor
{
    return objc_getAssociatedObject(self, &KEY_PROPERTY_WZLDAY_TEXTCOLOR);
}



@end
