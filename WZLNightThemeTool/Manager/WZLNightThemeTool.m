//
//  WZLNightThemeTool.m
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/23.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import "WZLNightThemeTool.h"
#import <objc/runtime.h>
#import "WZLNightConstants.h"
#import "WZLNightCategoryImport.h"

#define SELF_INSTANCE               [WZLNightThemeTool sharedInstance]

@interface WZLNightThemeTool ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableSet *> *registeredViewsNightColorDict;
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableSet *> *registeredViewsDayColorDict;

/**
 *  To record current mode
 */
@property (nonatomic, assign) WZLThemeMode currenThemeMode;

@end

@implementation WZLNightThemeTool

@synthesize currenThemeMode = _currenThemeMode;

- (instancetype)init
{
    if (self = [super init]) {
        _registeredViewsNightColorDict = [[NSMutableDictionary alloc] init];
        _registeredViewsDayColorDict = [[NSMutableDictionary alloc] init];
        _currenThemeMode = WZLThemeModeNotInit;
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static WZLNightThemeTool *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (s_instance == nil) {
            s_instance = [[WZLNightThemeTool alloc] init];
        }
    });
    return s_instance;
}

#pragma mark - public interface
+ (void)registerWithView:(id)view propertyName:(NSString *)propName forNightColor:(BOOL)bForNight
{
    NSParameterAssert(view);
    //view may be dealloced
    if (view == nil) {
        return;
    }
    NSMutableDictionary *refDictionary = bForNight ? SELF_INSTANCE.registeredViewsNightColorDict : SELF_INSTANCE.registeredViewsDayColorDict;
    NSMutableSet *correspondingSet = refDictionary[propName];
    if (correspondingSet == nil) {
        correspondingSet = [NSMutableSet set];
    }
    [correspondingSet addObject:view];
    [refDictionary setObject:correspondingSet forKey:propName];
}

+ (void)changeThemeColorRightNowIfNeedWithView:(id)view propertyName:(NSString *)propName
{
    NSParameterAssert(view);
    NSAssert(propName && [propName hasPrefix:@"WZL"], @"propName should have prefix WZL");
    NSString *systemColorPropertyName = nil;
    if (SELF_INSTANCE.currenThemeMode == WZLThemeModeNight && [propName hasPrefix:@"WZLNight"]) {
        systemColorPropertyName = WZLNightThemeToolNightAndSystemColorsMap()[propName];
        [SELF_INSTANCE applyColorWithTargetView:view wzlPropertyName:propName
                    systemPropertyName:systemColorPropertyName];
    } else if (SELF_INSTANCE.currenThemeMode == WZLThemeModeDay && [propName hasPrefix:@"WZLDay"]) {
        systemColorPropertyName = WZLNightThemeToolDayAndSystemColorsMap()[propName];
        [SELF_INSTANCE applyColorWithTargetView:view wzlPropertyName:propName systemPropertyName:systemColorPropertyName];
    }
}

+ (void)nightComes
{
    [SELF_INSTANCE enumerateToChangeToNightTheme];
    [SELF_INSTANCE setCurrenThemeMode:WZLThemeModeNight];
    [[NSNotificationCenter defaultCenter] postNotificationName:WZLNightDidComesNotification object:nil];
}

+ (void)dayComes
{
    [SELF_INSTANCE enumerateToChangeToDayTheme];
    [SELF_INSTANCE setCurrenThemeMode:WZLThemeModeDay];
    [[NSNotificationCenter defaultCenter] postNotificationName:WZLDayDidComesNotification object:nil];
}

#pragma mark - private methods

- (void)enumerateToChangeToNightTheme
{
    if (_currenThemeMode == WZLThemeModeNight || self.registeredViewsNightColorDict == nil || [self.registeredViewsNightColorDict count] == 0) {
        return;
    }
    
    [self.registeredViewsNightColorDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSMutableSet *registeredViewSet, BOOL *stop) {
        NSString *nightPropertyName = key;
        [registeredViewSet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            if ([obj isKindOfClass:[UIView class]]) {
                UIView *registeredView = (UIView *)obj;
                if (registeredView) {
                    NSString *systemColorPropertyName = WZLNightThemeToolNightAndSystemColorsMap()[nightPropertyName];
                    //[self backupDayColorBeforeChangingToNight:registeredView systemPropertyName:systemColorPropertyName];
                    
                    [self applyColorWithTargetView:registeredView wzlPropertyName:nightPropertyName
                                systemPropertyName:systemColorPropertyName];
                }
            }
        }];
    }];
}

- (void)enumerateToChangeToDayTheme
{
    if (_currenThemeMode == WZLThemeModeDay || self.registeredViewsNightColorDict == nil || [self.registeredViewsNightColorDict count] == 0) {
        return;
    }
    [self.registeredViewsDayColorDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSMutableSet *registeredViewSet, BOOL *stop) {
        NSString *dayPropertyName = key;
        
        [registeredViewSet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            if ([obj isKindOfClass:[UIView class]]) {
                UIView *registeredView = (UIView *)obj;
                if (registeredView) {
                    NSString *systemColorPropertyName = WZLNightThemeToolDayAndSystemColorsMap()[dayPropertyName];
                    [self applyColorWithTargetView:registeredView wzlPropertyName:dayPropertyName
                                systemPropertyName:systemColorPropertyName];
                }
            }
        }];
    }];
}

- (void)backupDayColorBeforeChangingToNight:(UIView *)targetView systemPropertyName:(NSString *)name
{
    NSParameterAssert(targetView);
    NSParameterAssert(name);
    id dayColorValue = [targetView valueForKeyPath:name];//dayColor may be nil, such as barTintColor.
    dayColorValue = [self replaceNilColorValueWithDefaultDayColorIfNeed:dayColorValue];
    if (dayColorValue) {
        NSString *WZLPropertyName = WZLNightThemeToolSystemAndDayColorsMap()[name];
        [targetView setValue:dayColorValue forKeyPath:WZLPropertyName];//
    }
}

//lines blow have the same effect as to "targetView.backgroundColor = targetView.WZLNightColor;"
- (void)applyColorWithTargetView:(UIView *)targetView
                      wzlPropertyName:(NSString *)WZLPropertyName
              systemPropertyName:(NSString *)sysPropertyName
{
    NSParameterAssert(targetView);
    NSParameterAssert(WZLPropertyName);
    NSParameterAssert(sysPropertyName);
    NSAssert([WZLNightThemeToolNightAndSystemColorsMap() count] == [WZLNightThemeToolNightAndSystemColorsMap() count] &&
             [WZLNightThemeToolNightAndSystemColorsMap() count] == [WZLNightThemeToolSystemAndDayColorsMap() count], @"some color property may be left.");
    id WZLColorValue = [targetView valueForKeyPath:WZLPropertyName];
    if (WZLColorValue) {
        [targetView setValue:WZLColorValue forKeyPath:sysPropertyName];
    }
}

- (UIColor *)replaceNilColorValueWithDefaultDayColorIfNeed:(UIColor *)color
{
    //in case color has no initial value
    if (color == nil) {
        return [UIColor whiteColor];
    }
    return color;
}

#pragma mark - setter and getter
- (WZLThemeMode)currenThemeMode
{
    if (_currenThemeMode == WZLThemeModeNotInit) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_THEME_MODE_WZLNIGHTTHEME]) {
            return [[[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_THEME_MODE_WZLNIGHTTHEME] integerValue];
        }
        return WZLThemeModeDay;
    } else {
        return _currenThemeMode;//read from memory directly
    }
}

- (void)setCurrenThemeMode:(WZLThemeMode)currenThemeMode
{
    _currenThemeMode = currenThemeMode;
    [[NSUserDefaults standardUserDefaults] setObject:@(currenThemeMode) forKey:UD_KEY_THEME_MODE_WZLNIGHTTHEME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
