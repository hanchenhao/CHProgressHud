//
//  CHProgressHud.m
//  ProgressHud
//
//  Created by 韩陈昊 on 16/9/6.
//  Copyright © 2016年 edai. All rights reserved.
//

#import "CHProgressHud.h"
#import "UIColor+Hex.h"

//  动图大小
const static CGFloat ImageHudConstraint = 93;

@interface CHProgressHud ()

@property (nonatomic , strong) UIImageView *imageView;
@property (nonatomic , strong) NSMutableArray *imageArray;
@property (nonatomic , strong) UIView *hudView;
@property (nonatomic , strong) UILabel *label;

@end

@implementation CHProgressHud

static int count = 0;

#pragma mark -setup

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (CHProgressHud *)sharedView {
    static dispatch_once_t once;
    static CHProgressHud *sharedView;
    dispatch_once(&once, ^ {
        sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    });
    return sharedView;
}

#pragma mark -lazy

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ImageHudConstraint, ImageHudConstraint)];
    }
    return _imageView;
}

- (UIView *)hudView{
    if (_hudView == nil) {
        _hudView = [[UIView alloc] init];
        _hudView.backgroundColor = [UIColor colorWithHexString:@"#000000"];
        _hudView.layer.cornerRadius = 8;
    }
    return _hudView;
}

- (NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
        for (int i = 1; i <= 6; i++) {
            
            [_imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%02d",i]]];
        }
    }
    return _imageArray;
}

- (UILabel *)label{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:14];

    }

    return _label;
}

#pragma mark -show and dismis 

- (void) show {
    count += 1;
    //  load image
    [CHProgressHud sharedView].imageView.animationImages = self.imageArray;
    [CHProgressHud sharedView].imageView.animationDuration = 2.0f;
    [[CHProgressHud sharedView].imageView startAnimating];
    
    [CHProgressHud sharedView].hudView.alpha = 1;
    
    //  window
    id<UIApplicationDelegate> delegate = ((id<UIApplicationDelegate>)[[UIApplication sharedApplication] delegate]);
    UIWindow *window = delegate.window;

    [CHProgressHud sharedView].hudView.frame = CGRectMake(0, 0, ImageHudConstraint, ImageHudConstraint);
    [CHProgressHud sharedView].hudView.center = CGPointMake(window.bounds.size.width /2.0f, window.bounds.size.height / 2.0f);
    [[CHProgressHud sharedView].hudView addSubview:[CHProgressHud sharedView].imageView];
    [[CHProgressHud sharedView] addSubview:[CHProgressHud sharedView].hudView];

    // mask
    CALayer *maskLayer = [ CALayer layer];
    [maskLayer setFrame:window.bounds];
    [maskLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [window.layer addSublayer:maskLayer];
    
    [window addSubview:[CHProgressHud sharedView]];
}


- (void)showMessage:(NSString *) msg {


    count += 1;
    [CHProgressHud sharedView].hudView.alpha = 1; //透明度
    [CHProgressHud sharedView].label.text = msg;    //信息
    [CHProgressHud sharedView].label.numberOfLines = 1;
    [[CHProgressHud sharedView].label sizeToFit];

    if ([CHProgressHud sharedView].label.frame.size.width > 200) {
        [CHProgressHud sharedView].label.numberOfLines = 0;
        [CHProgressHud sharedView].label.frame = CGRectMake(0, 0, 200, 0);
        [[CHProgressHud sharedView].label sizeToFit];

    }
    
    id<UIApplicationDelegate> delegate = ((id<UIApplicationDelegate>)[[UIApplication sharedApplication] delegate]);
    UIWindow *window = delegate.window;

    [CHProgressHud sharedView].hudView.frame = CGRectMake(0, 0, [CHProgressHud sharedView].label.frame.size.width + 30, [CHProgressHud sharedView].label.frame.size.height + 30);
    [CHProgressHud sharedView].label.center = [CHProgressHud sharedView].hudView.center;

    [CHProgressHud sharedView].hudView.center = CGPointMake(window.frame.size.width /2.0f, window.frame.size.height / 2.0f);
    [[CHProgressHud sharedView].hudView addSubview:[CHProgressHud sharedView].label];

    [[CHProgressHud sharedView] addSubview:[CHProgressHud sharedView].hudView];

    
    CALayer *maskLayer = [CALayer layer];
    [maskLayer setFrame:window.bounds];
    [maskLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [window.layer addSublayer:maskLayer];
    [window addSubview:[CHProgressHud sharedView]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[CHProgressHud sharedView] dismis];

    });

}


-  (void) dismis {
    [CHProgressHud sharedView].hudView.alpha = 0;
    count = 0;
    if ([CHProgressHud sharedView].imageView.animationImages) {
        [[CHProgressHud sharedView].imageView stopAnimating];
        [CHProgressHud sharedView].imageView.animationImages = nil;
    }

    // 移除之前子控制器的View
    [[CHProgressHud sharedView].hudView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[CHProgressHud sharedView] removeFromSuperview];
    

}

+ (void) show {
    if (count > 0) {
        [UIView animateWithDuration:.1f animations:^{
            [[CHProgressHud sharedView] dismis];
        } completion:^(BOOL finished) {
            [self show];
        }];
    } else {
        [[CHProgressHud sharedView] show];

    }
}

+ (void) showMessage:(NSString *) msg {
    if (count > 0) {
        [UIView animateWithDuration:.1f animations:^{
            [[CHProgressHud sharedView] dismis];
            
        } completion:^(BOOL finished) {
            [self showMessage:msg];
        }];
    } else {
        [[CHProgressHud sharedView] showMessage:msg];
        
    }
}

+ (void) dismis {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[CHProgressHud sharedView] dismis];

    });

}


- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


@end
