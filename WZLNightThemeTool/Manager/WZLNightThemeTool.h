//
//  WZLNightThemeTool.h
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/23.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const WZLNightDidComesNotification = @"WZLNightDidComesNotification";
static NSString *const WZLDayDidComesNotification = @"WZLDayDidComesNotification";

@interface WZLNightThemeTool : NSObject

+ (void)registerWithView:(id)view propertyName:(NSString *)propName forNightColor:(BOOL)bForNight;

+ (void)changeThemeColorRightNowIfNeedWithView:(id)view propertyName:(NSString *)propName;

+ (void)nightComes;

+ (void)dayComes;

@end
