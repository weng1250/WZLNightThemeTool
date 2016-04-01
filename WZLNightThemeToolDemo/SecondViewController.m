//
//  SecondViewController.m
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/28.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import "SecondViewController.h"
#import "WZLNightTheme.h"
#import "AppThemeColorDefines.h"
#import "TableViewDataSource.h"

@interface SecondViewController ()

@property (nonatomic, strong) TableViewDataSource *dataSource;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableView];
}

- (void)setupTableView
{
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger i = 0; i < 50; i++) {
        [items addObject:@"WZLNightTheme is an easy-to-use theme management tool."];
    }
    self.dataSource = [[TableViewDataSource alloc] initWithItems:items];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    //configure tableview night color
    self.tableView.WZLNightBackgroundColor = THEME_NIGHT_BACKGROUND_COLOR;
    self.tableView.WZLDayBackgroundColor = THEME_DAY_BACKGROUND_COLOR;
}

@end
