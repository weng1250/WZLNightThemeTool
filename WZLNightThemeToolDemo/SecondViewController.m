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

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.WZLNightBackgroundColor = THEME_NIGHT_BACKGROUND_COLOR;
}

@end
