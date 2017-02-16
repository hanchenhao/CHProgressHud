//
//  CHProgressHud.h
//  ProgressHud
//
//  Created by 韩陈昊 on 16/9/6.
//  Copyright © 2016年 edai. All rights reserved.
//

#define HudShow [CHProgressHud show];
#define HudShowMessage(msg) [CHProgressHud showMessage:msg];
#define HudDismiss [CHProgressHud dismis];


#import <UIKit/UIKit.h>

@interface CHProgressHud : UIView
/**
 *  创建hud
 *
 *  @return hud
 */
+ (CHProgressHud *)sharedView;

/**
 *  显示hud
 */
+ (void) show;


/**
 *  显示带文字的hud
 *
 *  @param msg 显示的文字信息
 */
+ (void) showMessage:(NSString *) msg ;

/**
 *  隐藏hud
 */
+ (void) dismis;
@end
