//
//  TableViewDataSource.h
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/29.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TableViewDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithItems:(NSArray *)items;

@end