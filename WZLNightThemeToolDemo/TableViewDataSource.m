//
//  TableViewDataSource.m
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/29.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import "TableViewDataSource.h"
#import "WZLNightTheme.h"
#import "AppThemeColorDefines.h"

@interface TableViewDataSource ()
@property (nonatomic, strong) NSArray *dataItems;
@end

@implementation TableViewDataSource

- (instancetype)initWithItems:(NSArray *)items
{
    NSParameterAssert(items);
    if (self = [super init]) {
        _dataItems = [NSArray arrayWithArray:items];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:@"logo.jpg"];
    cell.textLabel.text = self.dataItems[indexPath.row];
    cell.contentView.WZLNightBackgroundColor = THEME_NIGHT_BACKGROUND_COLOR;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
