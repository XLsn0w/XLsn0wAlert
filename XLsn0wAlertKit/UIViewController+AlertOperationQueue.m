//
//  UIViewController+AlertOperationQueue.m
//  XLsn0wAlert
//
//  Created by HL on 2018/7/20.
//  Copyright © 2018年 XL. All rights reserved.
//

#import "UIViewController+AlertOperationQueue.h"
#import <objc/runtime.h>

@implementation UIViewController (AlertOperationQueue)

- (NSOperationQueue *)sharedAlertOperationQueue {
    static NSOperationQueue *operationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        operationQueue = [NSOperationQueue new];
    });                                                                                                 
    return operationQueue;
}

- (void)setDisappearCompletion:(void (^)(void))completion {
    objc_setAssociatedObject(self, @selector(getDisappearCompletion), completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(void))getDisappearCompletion {
    return objc_getAssociatedObject(self, _cmd);
}

+ (void)load {
    [self exchangeFromAppleSEL:@selector(viewDidDisappear:) customSEL:@selector(xxx_viewDidDisappear:)];
//    [self exchangeFromAppleSEL:NSSelectorFromString(@"viewWillAppear:") customSEL:@selector(xl_viewWillAppear:)];
}

+ (void)exchangeFromAppleSEL:(SEL)appleSEL customSEL:(SEL)customSEL {
    Method appleMethod  = class_getInstanceMethod([self class], appleSEL);
    Method customMethod = class_getInstanceMethod([self class], customSEL);
    
    BOOL isAddMethod = class_addMethod(self, appleSEL, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
    if (isAddMethod) {
        class_replaceMethod(self, customSEL, method_getImplementation(appleMethod), method_getTypeEncoding(appleMethod));
    } else {
        method_exchangeImplementations(appleMethod, customMethod);
    }
}




- (void)xxx_viewDidDisappear:(BOOL)animated {
    [self xxx_viewDidDisappear:animated];
    if ([self getDisappearCompletion]) {
        [self getDisappearCompletion]();
    }
}

- (void)xl_presentViewController:(UIViewController *)controller completion:(void (^)(void))completion{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:controller animated:YES completion:completion];
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }];
    if ([self sharedAlertOperationQueue].operations.lastObject) {
        [operation addDependency:[self sharedAlertOperationQueue].operations.lastObject];
    }
    
    [[self sharedAlertOperationQueue] addOperation:operation];
}

@end
