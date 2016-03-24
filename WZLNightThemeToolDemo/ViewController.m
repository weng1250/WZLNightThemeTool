//
//  ViewController.m
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/23.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import "ViewController.h"
#import "WZLNightThemeTool.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UISwitch *themeSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.WZLNightBackgroundColor = [UIColor blackColor];
    self.themeSwitch.WZLNightTintColor = [UIColor blackColor];
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
