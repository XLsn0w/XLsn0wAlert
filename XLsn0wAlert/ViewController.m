//
//  ViewController.m
//  XLsn0wAlert
//
//  Created by HL on 2018/7/20.
//  Copyright © 2018年 XL. All rights reserved.
//

#import "ViewController.h"
#import "XLsn0wShow.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)show:(id)sender {
    XLsn0wShow *show = [XLsn0wShow new];
    [show showCenterWithText:@"重复叠加不会叠加XLsn0wShow"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
