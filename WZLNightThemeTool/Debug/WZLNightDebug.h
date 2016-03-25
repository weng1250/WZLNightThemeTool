//
//  WZLNightDebug.h
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/24.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#ifndef WZLNightDebug_h
#define WZLNightDebug_h

#ifdef DEBUG
#define WZLNightDebug       1
#endif

#ifdef  WZLNightDebug
#define WZLNightLog(...) NSLog(__VA_ARGS__)
#else
#define WZLNightLog(...)
#endif

#endif /* WZLNightDebug_h */
