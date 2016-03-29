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

#define SELF_INSTANCE               [WZLNightThemeTool sharedInstance]

@interface WZLNightThemeTool ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableSet *> *registeredViewsDict;

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
        _registeredViewsDict = [[NSMutableDictionary alloc] init];
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
+ (void)registerNightWithView:(id)view propertyName:(NSString *)propName
{
    NSParameterAssert(view);
    //view may be dealloced
    if (view == nil) {
        return;
    }
    NSMutableSet *correspondingSet = SELF_INSTANCE.registeredViewsDict[propName];
    if (correspondingSet == nil) {
        correspondingSet = [NSMutableSet set];
    }
    [correspondingSet addObject:view];
    [SELF_INSTANCE.registeredViewsDict setObject:correspondingSet forKey:propName];
}

+ (void)nightComes
{
    [SELF_INSTANCE setCurrenThemeMode:WZLThemeModeNight];
    [SELF_INSTANCE enumerateToChangeToNightTheme];
    [[NSNotificationCenter defaultCenter] postNotificationName:WZLNightDidComesNotification object:nil];
}

+ (void)dayComes
{
    [SELF_INSTANCE setCurrenThemeMode:WZLThemeModeDay];
    [SELF_INSTANCE enumerateToChangeToDayTheme];
    [[NSNotificationCenter defaultCenter] postNotificationName:WZLDayDidComesNotification object:nil];
}

#pragma mark - private methods

- (void)enumerateToChangeToNightTheme
{
    if (self.registeredViewsDict == nil || [self.registeredViewsDict count] == 0) {
        return;
    }
    
    [self.registeredViewsDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSMutableSet *registeredViewSet, BOOL *stop) {
        NSString *WZLPropertyName = key;
        [registeredViewSet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            if ([obj isKindOfClass:[UIView class]]) {
                UIView *registeredView = (UIView *)obj;
                if (registeredView) {
                    NSString *systemColorPropertyName = WZLNightThemeToolNightAndSystemColorsMap()[WZLPropertyName];
                    [self backupDayColorBeforeChangingToNight:registeredView systemPropertyName:systemColorPropertyName];
                    
                    [self applyColorWithTargetView:registeredView wzlPropertyName:WZLPropertyName
                                systemPropertyName:systemColorPropertyName];
                }
            }
        }];
    }];
}

- (void)enumerateToChangeToDayTheme
{
    if (self.registeredViewsDict == nil || [self.registeredViewsDict count] == 0) {
        return;
    }
    [self.registeredViewsDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSMutableSet *registeredViewSet, BOOL *stop) {
        NSString *WZLNightPropertyName = key;
        NSString *WZLDayPropertyName = WZLNightThemeToolNightAndDayColorsMap()[WZLNightPropertyName];
        NSAssert(WZLDayPropertyName, @"property name parse error");
        
        [registeredViewSet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            if ([obj isKindOfClass:[UIView class]]) {
                UIView *registeredView = (UIView *)obj;
                if (registeredView) {
                    NSString *systemColorPropertyName = WZLNightThemeToolNightAndSystemColorsMap()[WZLNightPropertyName];
                    [self applyColorWithTargetView:registeredView wzlPropertyName:WZLDayPropertyName
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
    //NSAssert(dayColorValue, @"dayColorValue should not be nil");
    if (dayColorValue) {
        NSString *WZLPropertyName = WZLNightThemeToolSystemAndDayColorsMap()[name];
        [targetView setValue:dayColorValue forKeyPath:WZLPropertyName];//
    }
}

//lines blow  the same effect as to "targetView.backgroundColor = targetView.WZLNightColor;"
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
        if ([[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_THEME_MODE]) {
            return [[[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_THEME_MODE] integerValue];
        }
        return WZLThemeModeDay;
    } else {
        return _currenThemeMode;//read from memory directly
    }
}

- (void)setCurrenThemeMode:(WZLThemeMode)currenThemeMode
{
    _currenThemeMode = currenThemeMode;
    [[NSUserDefaults standardUserDefaults] setObject:@(currenThemeMode) forKey:UD_KEY_THEME_MODE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
