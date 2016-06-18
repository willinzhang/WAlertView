//
//  WAlertView.h
//  WAlertView
//
//  Created by 张伟立 on 16/6/17.
//  Copyright © 2016年 com.william. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAlertView : UIView

/**
 *  创建alertview
 *
 *  @param title          标题文字
 *  @param titleColor     标题颜色
 *  @param massage        内容文字
 *  @param massageColor   内容颜色
 *  @param BGColor        alertview背景颜色
 *  @param isCornerRadius 是否切圆角
 */
+(void)alertViewWithTitle:(NSString *)title titleColor:(UIColor *)titleColor massage:(NSString *)massage massageColor:(UIColor *)massageColor alertViewBGColor:(UIColor *)BGColor isCornerRadius:(BOOL)isCornerRadius;

/**
 *  自定义按钮
 *
 *  @param leftTitel      左侧按钮文字
 *  @param rightTitle        右侧按钮文字
 *  @param leftTitleColor 左侧按钮文字颜色
 *  @param rightTitleColor   右侧按钮文字颜色
 *  @param leftHandle     左侧按钮点击效果block回调
 *  @param rightHandle       右侧按钮点击效果block回调
 *  填写一个title 默认为只有一个按钮的alertview 如果填写leftTitle或者rightTitle 可以更改默认按钮的文字和颜色
 */
+ (void)alertActionWithLeftTitle:(NSString *)leftTitel rightTitle:(NSString *)rightTitle leftTitleColor:(UIColor *)leftTitleColor rightTitleColor:(UIColor *)rightTitleColor leftHandle:(void (^)())leftHandle rightHandle:(void (^)())rightHandle;


@end
