//
//  UIColor+Hex.h
//  p2p
//
//  Created by skyz on 16/3/10.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/** 从十六进制字符串获取颜色  */
//	color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color;
/** 从十六进制字符串获取颜色 并设置alpha */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
