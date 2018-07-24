//
//  MacroSingleton.h
//  XLsn0wAlert
//
//  Created by HL on 2018/7/24.
//  Copyright © 2018年 XL. All rights reserved.
//

#import <Foundation/Foundation.h>

#define singleton_interface(class) + (instancetype)shared##class;

