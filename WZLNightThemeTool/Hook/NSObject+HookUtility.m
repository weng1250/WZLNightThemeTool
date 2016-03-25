//
//  UIView+HookUtility.m
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/25.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import "NSObject+HookUtility.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

//just used to validate selectors, using dispatch_once to make sure of allocation once for cls
static UIView * WEmptyObjectToAssert(Class cls) {
    static id _view = nil;
    if (_view && [_view isKindOfClass:cls]) {
        return _view;
    }
    _view = [[cls alloc] init];
    return _view;
}

@implementation UIView (HookUtility)

+ (void)swizzleWithOriginalSel:(SEL)orignalSel newSel:(SEL)newSel class:(Class)cls
{
    Method originalMethod = class_getInstanceMethod(cls, orignalSel);
    Method newMethod = class_getInstanceMethod(cls, newSel);
    IMP originalImp = method_getImplementation(originalMethod);
    IMP newImp = method_getImplementation(newMethod);
    
    BOOL didAddedNewMethod = class_addMethod(cls, orignalSel, newImp, method_getTypeEncoding(originalMethod));
    if (didAddedNewMethod) {
        class_replaceMethod(cls, newSel, originalImp, method_getTypeEncoding(newMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

+ (void)swizzleSelectorsWithWZLNightSupportedColorsProperty:(NSArray *)supportColorProperties class:(Class)cls
{
    NSParameterAssert(supportColorProperties);
    [supportColorProperties enumerateObjectsUsingBlock:^(NSString *propertyName, NSUInteger idx, BOOL *stop) {
        NSString *originalSelName = [NSString stringWithFormat:@"set%@:", propertyName];
        NSString *mySwizzleSelName = [NSString stringWithFormat:@"swizzle_set%@:", propertyName];
        SEL originalSel = NSSelectorFromString(originalSelName);
        SEL mySwizzleSel = NSSelectorFromString(mySwizzleSelName);
        NSAssert([WEmptyObjectToAssert(cls) respondsToSelector:originalSel], @"selector:%@ not found in class:%@", originalSelName, cls);
        NSAssert([WEmptyObjectToAssert(cls) respondsToSelector:mySwizzleSel], @"selector:%@ not found in class:%@", mySwizzleSelName, cls);
        [self swizzleWithOriginalSel:originalSel newSel:mySwizzleSel class:cls];
    }];

}


@end
