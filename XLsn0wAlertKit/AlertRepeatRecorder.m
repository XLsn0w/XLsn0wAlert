
#import "AlertRepeatRecorder.h"

@implementation AlertRepeatRecorder

// 创建单例，记录alertView
+ (AlertRepeatRecorder *)shared {
    static AlertRepeatRecorder *recoder = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(recoder == nil){
            recoder = [[AlertRepeatRecorder alloc] init];
        }
    });
    return recoder;
}

- (instancetype)init {
    if (self = [super init]) {
        self.alertViewArray = [[NSMutableArray alloc] init];
        self.shows = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
