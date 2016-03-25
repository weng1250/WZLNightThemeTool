//
//  ViewController.m
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/23.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import "ViewController.h"
#import "WZLNightThemeTool.h"

#define GLOBAL_THEME_COLOR [UIColor blackColor]

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UISwitch *themeSwitch;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.WZLNightBackgroundColor = [UIColor blackColor];
    self.themeSwitch.WZLNightTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = GLOBAL_THEME_COLOR;
    self.textLabel.WZLNightTextColor = [UIColor whiteColor];
}

- (IBAction)onThemeSwitchClicked:(UISwitch *)sender
{
    if (sender.on) {
        [WZLNightThemeTool nightComes];
    } else {
        [WZLNightThemeTool dayComes];
    }
}

@end
