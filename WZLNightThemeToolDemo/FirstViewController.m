//
//  FirstViewController
//  WZLNightThemeToolDemo
//
//  Created by wengzilin on 16/3/23.
//  Copyright © 2016年 Weng-Zilin(http://www.cnblogs.com/wengzilin/). All rights reserved.
//

#import "FirstViewController.h"
#import "WZLNightTheme.h"
#import "AppThemeColorDefines.h"

@interface FirstViewController ()

@property (strong, nonatomic) IBOutlet UISwitch *themeSwitch;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Home";
    [self setupViews];
}

- (void)setupViews
{
    UIBarButtonItem *rightNaviItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(onNextItemPressed:)];
    self.navigationController.navigationItem.rightBarButtonItem = rightNaviItem;
    self.navigationController.navigationBar.WZLNightBarTintColor = THEME_NIGHT_NAVIBAR_COLOR;
    self.view.WZLNightBackgroundColor = THEME_NIGHT_BACKGROUND_COLOR;
    self.themeSwitch.WZLNightTintColor = THEME_NIGHT_BACKGROUND_COLOR;
    self.textLabel.WZLNightTextColor = THEME_NIGHT_TEXT_COLOR;
}

- (IBAction)onThemeSwitchClicked:(UISwitch *)sender
{
    NSLog(@"navi bar color:%@", self.navigationController.navigationBar.tintColor);
    if (sender.on) {
        [WZLNightTheme nightComes];
    } else {
        [WZLNightTheme dayComes];
    }
}
- (IBAction)onNextItemPressed:(id)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *nextVC = [sb instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    nextVC.title = @"Detail ViewController";
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
