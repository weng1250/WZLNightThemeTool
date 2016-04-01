//
//  AppConfig.m
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/4/1.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import "AppConfig.h"

#define UD_APP_THEME_MODE      @"UD_APP_THEME_MODE"

@implementation AppConfig

@synthesize isInNightMode = _isInNightMode;

+ (AppConfig *)sharedInstance
{
    static AppConfig *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (s_instance == nil) {
            s_instance = [[AppConfig alloc] init];
        }
    });
    return s_instance;
}

- (void)setIsInNightMode:(BOOL)isInNightMode
{
    [[NSUserDefaults standardUserDefaults] setObject:@(isInNightMode) forKey:UD_APP_THEME_MODE];
}

- (BOOL)isInNightMode
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:UD_APP_THEME_MODE]) {
        return [[[NSUserDefaults standardUserDefaults] objectForKey:UD_APP_THEME_MODE] boolValue];
    }
    return NO;
}

@end
