
#import <Foundation/Foundation.h>

@interface AlertRepeatRecorder : NSObject

@property (nonatomic, strong) NSMutableArray *alertViewArray;
@property (nonatomic, strong) NSMutableArray *shows;

+ (AlertRepeatRecorder *)shared;

@end
