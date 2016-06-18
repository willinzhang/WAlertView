//
//  UILabel+UILabel_LabelHeightAndWidth.h
//  LearningCenterIPad
//
//  Created by 张伟立 on 16/6/3.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (UILabel_LabelHeightAndWidth)
/**
 *  UILabel 自适应的高度
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;
/**
 *  UILabel 自适应的宽度
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end
