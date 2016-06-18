//
//  UILabel+UILabel_LabelHeightAndWidth.m
//  LearningCenterIPad
//
//  Created by 张伟立 on 16/6/3.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "UILabel+UILabel_LabelHeightAndWidth.h"

@implementation UILabel (UILabel_LabelHeightAndWidth)
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
@end
