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
#import "WZLNightThemeTool.h"
#import "WZLNightDebug.h"

//static NSArray *array = @[...] is invalid
static NSArray * WZLNightThemeToolSupportedColorProperties() {
    static NSArray *_WZLNightThemeToolSupportedColorProperties = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _WZLNightThemeToolSupportedColorProperties = @[@"WZLNightBackgroundColor", @"WZLNightTintColor", @"WZLNightTextColor"];
    });
    return _WZLNightThemeToolSupportedColorProperties;
}

//just used to validate selectors, using dispatch_once to make sure of allocation once
static UIView * WEmptyObjectToAssert() {
    static UIView *_view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _view = [[UIView alloc] init];
    });
    return _view;
}

@implementation UIView (HookNightTheme)

+ (void)load
{
    NSArray *supportColorProperties = WZLNightThemeToolSupportedColorProperties();
    [supportColorProperties enumerateObjectsUsingBlock:^(NSString *propertyName, NSUInteger idx, BOOL *stop) {
        NSString *originalSelName = [NSString stringWithFormat:@"set%@:", propertyName];
        NSString *mySwizzleSelName = [NSString stringWithFormat:@"swizzle_set%@:", propertyName];
        SEL originalSel = NSSelectorFromString(originalSelName);
        SEL mySwizzleSel = NSSelectorFromString(mySwizzleSelName);
        //NSAssert([WEmptyObjectToAssert() respondsToSelector:originalSel] &&
        //         [WEmptyObjectToAssert() respondsToSelector:mySwizzleSel], @"selector does not exist!");
        [self swizzleWithOriginalSel:originalSel newSel:mySwizzleSel];
    }];
}

+ (void)swizzleWithOriginalSel:(SEL)orignalSel newSel:(SEL)newSel
{
    Method originalMethod = class_getInstanceMethod([self class], orignalSel);
    Method newMethod = class_getInstanceMethod([self class], newSel);
    IMP originalImp = method_getImplementation(originalMethod);
    IMP newImp = method_getImplementation(newMethod);
    
    BOOL didAddedNewMethod = class_addMethod([self class], orignalSel, newImp, method_getTypeEncoding(originalMethod));
    if (didAddedNewMethod) {
        class_replaceMethod([self class], newSel, originalImp, method_getTypeEncoding(newMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

#pragma mark - swizzle method to be injected

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

- (void)swizzle_setWZLNightTextColor:(UIColor *)color
{
    [WZLNightThemeTool registerNightWithView:self propertyName:@"WZLNightTextColor"];
    [self swizzle_setWZLNightTextColor:color];
}



@end
