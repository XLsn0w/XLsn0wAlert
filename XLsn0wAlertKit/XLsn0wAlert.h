
#import <UIKit/UIKit.h>
#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#endif
#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#endif
NS_ASSUME_NONNULL_BEGIN

@interface XLsn0wAlert : UIViewController

@property (nonatomic,strong)UIView *contentView;

@property (nonatomic, readonly) NSArray<UIAlertAction *> *actions;

+(instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;
- (void)addAction:(UIAlertAction *)action;

@end

@interface XLsn0wAction : UIAlertAction

@property (nonatomic, copy, nullable) void(^handler)(XLsn0wAction *alertAction);

@end
NS_ASSUME_NONNULL_END
