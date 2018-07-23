//
//  ViewController.m
//  XLsn0wAlert
//
//  Created by HL on 2018/7/20.
//  Copyright © 2018年 XL. All rights reserved.
//

#import "ViewController.h"
#import "XLsn0wAlertKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)show:(id)sender {
    XLsn0wShow *show = [XLsn0wShow new];
    [show showCenterWithText:@"重复点击不会叠加XLsn0wShow"];
}

- (IBAction)alert:(id)sender {
    XLsn0wAlert *controller = [XLsn0wAlert alertControllerWithTitle:@"警告" message:@"请退出登录"];
    
    XLsn0wAction *action1 = [XLsn0wAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    XLsn0wAction *action2 = [XLsn0wAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确定");
    }];
    [controller addAction:action1];
    [controller addAction:action2];
    
    [self presentViewController:controller animated:YES completion:^{
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
