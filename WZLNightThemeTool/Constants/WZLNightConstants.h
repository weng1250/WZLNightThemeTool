//
//  WZLNightConstants.h
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/29.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#ifndef WZLNightConstants_h
#define WZLNightConstants_h
#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, WZLThemeMode)
{
    WZLThemeModeNotInit = 0,
    WZLThemeModeDay,
    WZLThemeModeNight
};

#define UD_KEY_IS_NIGHT_MODE        @"UD_KEY_IS_NIGHT_MODE"

static NSDictionary * WZLNightThemeToolNightAndSystemColorsMap() {
    static NSDictionary *_WZLNightThemeToolNightAndSystemColorsMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _WZLNightThemeToolNightAndSystemColorsMap = @{@"WZLNightBackgroundColor" : @"backgroundColor",
                                                      @"WZLNightTintColor" : @"tintColor",
                                                      @"WZLNightTextColor" : @"textColor",
                                                      @"WZLNightBarTintColor" : @"barTintColor"};
    });
    return _WZLNightThemeToolNightAndSystemColorsMap;
}

static NSDictionary * WZLNightThemeToolSystemAndDayColorsMap() {
    static NSDictionary *_WZLNightThemeToolSystemAndDayColorsMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _WZLNightThemeToolSystemAndDayColorsMap = @{@"backgroundColor" : @"WZLDayBackgroundColor",
                                                    @"tintColor" : @"WZLDayTintColor",
                                                    @"textColor" : @"WZLDayTextColor",
                                                    @"barTintColor" : @"WZLDayBarTintColor"};
    });
    return _WZLNightThemeToolSystemAndDayColorsMap;
}

static NSDictionary * WZLNightThemeToolNightAndDayColorsMap() {
    static NSDictionary *_WZLNightThemeToolNightAndDayColorsMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _WZLNightThemeToolNightAndDayColorsMap = @{@"WZLNightBackgroundColor" : @"WZLDayBackgroundColor",
                                                   @"WZLNightTintColor" : @"WZLDayTintColor",
                                                   @"WZLNightTextColor" : @"WZLDayTextColor",
                                                   @"WZLNightBarTintColor" : @"WZLDayBarTintColor"};
    });
    return _WZLNightThemeToolNightAndDayColorsMap;
}


#endif /* WZLNightConstants_h */
