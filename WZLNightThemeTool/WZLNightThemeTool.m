//
//  WZLNightTheme.m
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/29.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import "WZLNightThemeTool.h"
#import "WZLNightThemeManager.h"

@implementation WZLNightThemeTool

+ (void)nightComes
{
    [WZLNightThemeManager nightComes];
}

+ (void)dayComes
{
    [WZLNightThemeManager dayComes];
}

@end
