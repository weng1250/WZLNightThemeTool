//
//  WZLNightThemeTool.m
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/23.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import "WZLNightThemeTool.h"
#import <objc/runtime.h>

#define SELF_INSTANCE       [WZLNightThemeTool sharedInstance]

static NSDictionary * WZLNightThemeToolNightAndSystemColorsMap() {
    static NSDictionary *_WZLNightThemeToolNightAndSystemColorsMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _WZLNightThemeToolNightAndSystemColorsMap = @{@"WZLNightBackgroundColor" : @"backgroundColor",
                                        @"WZLNightTintColor" : @"tintColor",
                                        @"WZLNightTextColor" : @"textColor"};
    });
    return _WZLNightThemeToolNightAndSystemColorsMap;
}

static NSDictionary * WZLNightThemeToolSystemAndDayColorsMap() {
    static NSDictionary *_WZLNightThemeToolSystemAndDayColorsMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _WZLNightThemeToolSystemAndDayColorsMap = @{@"backgroundColor" : @"WZLDayBackgroundColor",
                                           @"tintColor" : @"WZLDayTintColor",
                                           @"textColor" : @"WZLDayTextColor"};
    });
    return _WZLNightThemeToolSystemAndDayColorsMap;
}

static NSDictionary * WZLNightThemeToolNightAndDayColorsMap() {
    static NSDictionary *_WZLNightThemeToolNightAndDayColorsMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _WZLNightThemeToolNightAndDayColorsMap = @{@"WZLNightBackgroundColor" : @"WZLDayBackgroundColor",
                                                   @"WZLNightTintColor" : @"WZLDayTintColor",
                                                   @"WZLNightTextColor" : @"WZLDayTextColor"};
    });
    return _WZLNightThemeToolNightAndDayColorsMap;
}



@interface WZLNightThemeTool ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableSet *> *registeredViewsDict;

@end

@implementation WZLNightThemeTool

- (instancetype)init
{
    if (self = [super init]) {
        _registeredViewsDict = [[NSMutableDictionary alloc] init];
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
    [SELF_INSTANCE enumerateToChangeToNightTheme];
    [[NSNotificationCenter defaultCenter] postNotificationName:WZLNightDidComesNotification object:nil];
}

+ (void)dayComes
{
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
    id dayColorValue = [targetView valueForKeyPath:name];
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
    id WZLColorValue = [targetView valueForKeyPath:WZLPropertyName];
    if (WZLColorValue) {
        [targetView setValue:WZLColorValue forKeyPath:sysPropertyName];
    }
}

@end
