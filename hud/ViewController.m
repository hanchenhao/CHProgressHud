//
//  ViewController.m
//  hud
//
//  Created by 韩陈昊 on 2017/2/13.
//  Copyright © 2017年 韩陈昊. All rights reserved.
//

#import "ViewController.h"
#import "CHProgressHud.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)imageHud:(id)sender {
   
    HudShow
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        HudDismiss
    });
}
- (IBAction)messageHud:(id)sender {
    HudShowMessage(@"文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字")
}
- (IBAction)closeHud:(id)sender {
    HudDismiss
}

@end
