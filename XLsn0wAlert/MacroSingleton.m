//
//  MacroSingleton.m
//  XLsn0wAlert
//
//  Created by HL on 2018/7/24.
//  Copyright © 2018年 XL. All rights reserved.
//

#import "MacroSingleton.h"

#define singleton_implementation(class) \
static class *_instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
\
return _instance; \
} \
\
+ (instancetype)shared##class \
{ \
if (_instance == nil) { \
_instance = [[class alloc] init]; \
} \
\
return _instance; \
}

