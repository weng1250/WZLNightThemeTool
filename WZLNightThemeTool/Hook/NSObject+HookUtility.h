//
//  UIView+HookUtility.h
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/25.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (HookUtility)

+ (void)swizzleWithOriginalSel:(SEL)orignalSel newSel:(SEL)newSel class:(Class)cls;

+ (void)swizzleSelectorsWithWZLNightSupportedColorsProperty:(NSArray *)supportColorProperties class:(Class)cls;

@end
