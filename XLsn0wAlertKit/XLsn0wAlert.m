
#import "XLsn0wAlert.h"

@interface LoadViewControllerAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@end

@interface XLsn0wAlert ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, readwrite) NSArray<XLsn0wAction *> *actions;
@property (nonatomic, copy)NSString *titleStr;
@property (nonatomic, copy)NSString *msgStr;
@property (nonatomic, strong) XLsn0wAction *cancelAction;
@property (nonatomic, strong) XLsn0wAction *defaultAction;

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *messageLabel;
@property (nonatomic, strong)UIButton *cancelButton;
@property (nonatomic, strong)UIButton *defaultButton;
@end

@implementation XLsn0wAlert
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message{
    XLsn0wAlert *alert = [[XLsn0wAlert alloc]init];
    alert.titleStr = title;
    alert.msgStr = message;
    alert.modalPresentationStyle = UIModalPresentationCustom;
    alert.transitioningDelegate = alert;
    return alert;
}
- (void)addAction:(XLsn0wAction *)action{
    //方法可接受空Action,但不做任何处理
    if (!action) {
        return;
    }
    //如果是destructiveAction暂时不做处理
    if (action.style == UIAlertActionStyleDestructive) {
        return;
    }
    //如果是cancelAction则单独赋值保存
    if (action.style == UIAlertActionStyleCancel) {
        self.cancelAction = action;
        return;
    }
    //如果是defaultAction则单独赋值保存
    if (action.style == UIAlertViewStyleDefault) {
        self.defaultAction = action;
        return;
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTouchesRequired = 1; //手指数
    tap.numberOfTapsRequired = 1; //tap次数
    [self.view addGestureRecognizer:tap];
    //content
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 4;
    contentView.userInteractionEnabled = YES;
    self.contentView = contentView;
    [self.view addSubview:contentView];
    //title
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor colorWithRed:31.00/255.00 green:36.00/255.00 blue:39.00/255.00 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.titleStr;
    [contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    //message
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.textColor = [UIColor colorWithRed:130.00/255.00 green:135.00/255.00 blue:154.00/255.00 alpha:1];
    messageLabel.font = [UIFont systemFontOfSize:15];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 2;
    messageLabel.text = self.msgStr;
    [contentView addSubview:messageLabel];
    self.messageLabel = messageLabel;
    
    if (self.cancelAction) {
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.layer.cornerRadius = 20;
        cancelButton.layer.borderWidth = 1;
        cancelButton.layer.borderColor = [[UIColor colorWithRed:246.00/255.00 green:206.00/255.00 blue:151.00/255.00 alpha:1] CGColor];
        [cancelButton setTitleColor:[UIColor colorWithRed:240.00/255.00 green:147.00/255.00 blue:21.00/255.00 alpha:1] forState:UIControlStateNormal];
        [cancelButton setTitle:self.cancelAction.title forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:cancelButton];
        self.cancelButton = cancelButton;
    }
    if (self.defaultAction) {
        UIButton *defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        defaultButton.layer.cornerRadius = 20;
        defaultButton.layer.borderWidth = 1;
        defaultButton.layer.borderColor = [[UIColor colorWithRed:236.00/255.00 green:236.00/255.00 blue:236.00/255.00 alpha:1] CGColor];
        [defaultButton setTitleColor:[UIColor colorWithRed:130.00/255.00 green:135.00/255.00 blue:154.00/255.00 alpha:1] forState:UIControlStateNormal];
        [defaultButton setTitle:self.defaultAction.title forState:UIControlStateNormal];
        defaultButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [defaultButton addTarget:self action:@selector(defaultButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:defaultButton];
        self.defaultButton = defaultButton;

    }
    
    [self addConstraints];
//    self.view.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.3];
    // Do any additional setup after loading the view.
}

- (void)addConstraints{
     self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:30]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-30]];
     [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    if ([self.titleStr length]) {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:15]];
        [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15]];
        [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:30]];
        [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:22.5]];
        [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:210]];
    }else{
        [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:170]];
    }
    if ([self.msgStr length]) {
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:15]];
        [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15]];
         [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:42]];
        if ([self.titleStr length]) {
            [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:67]];
        }else{
             [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:30]];
        }
    }
    if (self.cancelAction) {
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-30]];
        [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
        if (self.defaultAction) {
            [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:15]];
            [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.defaultButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-15]];
            [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.defaultButton attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
        }else{
            [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:62.5]];
            [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-62.5]];
        }
    }
    if (self.defaultAction) {
        self.defaultButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.defaultButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-30]];
        [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.defaultButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
        if (self.cancelAction) {
            [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.defaultButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15]];
            [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.defaultButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.cancelButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:15]];
        }else{
            [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.defaultButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:62.5]];
            [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.defaultButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-62.5]];
        }

    }
}


- (void)cancelButtonAction:(UIButton *)sender{
    self.cancelAction.handler(self.cancelAction);
    self.cancelAction.handler = nil;
    self.defaultAction.handler = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)hide {
    self.cancelAction.handler(self.cancelAction);
    self.cancelAction.handler = nil;
    self.defaultAction.handler = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)defaultButtonAction:(UIButton *)sender{
    self.defaultAction.handler(self.defaultAction);
    self.cancelAction.handler = nil;
    self.defaultAction.handler = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[LoadViewControllerAnimatedTransitioning alloc]init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[LoadViewControllerAnimatedTransitioning alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation LoadViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (toVC.isBeingPresented) {
        return 0.4;
    }
    else if (fromVC.isBeingDismissed) {
        return 0.1;
    }
    
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    XLsn0wAlert *toVC = (XLsn0wAlert*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (!toVC || !fromVC) {
        return;
    }
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (toVC.isBeingPresented) {
        [containerView addSubview:toVC.view];
        CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        popAnimation.duration = 0.4;
        popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1f, 0.1f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 0.9f)],
                                [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
        popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [toVC.contentView.layer addAnimation:popAnimation forKey:nil];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }
    else if (fromVC.isBeingDismissed) {
        [UIView animateWithDuration:duration animations:^{
            fromVC.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
}

@end

@implementation XLsn0wAction

+(instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction * _Nonnull))handler{
    XLsn0wAction *action = [super actionWithTitle:title style:style handler:handler];
    action.handler = handler;
    return action;
}

@end



