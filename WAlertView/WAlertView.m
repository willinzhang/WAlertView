//
//  WAlertView.m
//  WAlertView
//
//  Created by 张伟立 on 16/6/17.
//  Copyright © 2016年 com.william. All rights reserved.
//

#import "WAlertView.h"
#import "UIView+Extension.h"
#import "UILabel+UILabel_LabelHeightAndWidth.h"

#define  WINDOW_WIDTH   [UIScreen mainScreen].bounds.size.width
#define  WINDOW_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define  mLabelPaddingLeftAndRight  26
#define  mLabelPaddingTop  22
#define  tLabelPaddingBottom  21
#define  tLabelPaddingTop  13
#define  BTN_HEIGHT  37
#define  MARK_Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define  UIWINDOW       [[UIApplication sharedApplication].windows objectAtIndex:0]



// 定义一个无返回值的block类型
typedef void (^ActionBlock)(void);


@interface WAlertView()
{
    // 按钮数量
    int _btnCount;
    BOOL isLeft;
}
// 定义block属性
@property (copy,nonatomic) ActionBlock actionleftBlock;
@property (copy,nonatomic) ActionBlock actionrightBlock;

//superView 要显示在的父视图
@property (nonatomic,weak) UIView *showInView;

@property (strong, nonatomic) UIView *centerView;

@property (strong, nonatomic) UIButton *defaultBtn;

@end

@implementation WAlertView

+ (WAlertView *)shareAlertViewWithW
{
    static dispatch_once_t once;
    static WAlertView *alertView;
    dispatch_once(&once, ^{
        UIWindow *window = UIWINDOW;
        alertView = [[self alloc]initWithFrame:window.bounds];
        alertView.showInView = window;
        alertView.backgroundColor = MARK_Color(0, 0, 0, 0.7);
        
    });
    return alertView;
}

/*
+ (UIView *)getWindows
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    NSArray *windowViews = [window subviews];
    UIView *subView = nil;
    if(windowViews && [windowViews count] > 0){
        subView = [windowViews objectAtIndex:[windowViews count]-1];
        for(UIView *aSubView in subView.subviews)
        {
            [aSubView.layer removeAllAnimations];
        }
    }
    return subView;
}
*/


- (void)addAlertViewWithTitle:(NSString *)title titleColor:(UIColor *)titleColor massage:(NSString *)massage massageColor:(UIColor *)massageColor alertViewBGColor:(UIColor *)BGColor isCornerRadius:(BOOL)isCornerRadius
{
    
    self.centerView = [[UIView alloc] init];
    self.centerView.width = 320;
    self.centerView.height = 103;
    
    self.centerView.centerX = UIWINDOW.center.x;
    self.centerView.centerY = UIWINDOW.center.y;
    
    self.centerView.backgroundColor = BGColor;
    
    if (isCornerRadius) {
        self.centerView.layer.cornerRadius = 4;
        self.centerView.layer.masksToBounds = YES;
    }
    
    [self addSubview:self.centerView];
    
    UILabel *titleLabel = nil;
    if (title && title.length > 0) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.width = self.centerView.width - mLabelPaddingLeftAndRight *2;
        titleLabel.height = [UILabel getHeightByWidth:titleLabel.width title:title font:[UIFont systemFontOfSize:17]];
        titleLabel.centerX = self.centerView.width / 2;
        titleLabel.y = mLabelPaddingTop;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        titleLabel.textColor = titleColor;
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.numberOfLines = 0;
        [self.centerView addSubview:titleLabel];
    }
    
    UILabel *massageLabel = nil;
    if (massage && massage.length > 0) {
        massageLabel = [[UILabel alloc] init];
        massageLabel.width = self.centerView.width - mLabelPaddingLeftAndRight *2;
        massageLabel.height = [UILabel getHeightByWidth:titleLabel.width title:massage font:[UIFont systemFontOfSize:15]];
        massageLabel.centerX = self.centerView.width / 2;
        if (titleLabel) {
            massageLabel.y = tLabelPaddingTop + titleLabel.height + mLabelPaddingTop;
        }else {
            massageLabel.y = mLabelPaddingTop;
        }
        massageLabel.textAlignment = NSTextAlignmentCenter;
        massageLabel.text = massage;
        massageLabel.textColor = massageColor;
        massageLabel.font = [UIFont systemFontOfSize:15];
        massageLabel.numberOfLines = 0;
        [self.centerView addSubview:massageLabel];
    }
    

    
    _btnCount = 0;
    
    
    [self checkCenterViewFrameWithMassageHeight:massageLabel.height titleHeight:titleLabel.height];
    [self checkBtnWithLeftTitle:nil rightTitle:nil leftTitleColor:nil rightTitleColor:nil];


    [self.showInView addSubview:self];
    
}

// 以block形式回调了VC中的执行方法
- (void)addActionWithLeftTitle:(NSString *)leftTitel rightTitle:(NSString *)rightTitle leftTitleColor:(UIColor *)leftTitleColor rightTitleColor:(UIColor *)rightTitleColor leftHandle:(void (^)())leftHandle rightHandle:(void (^)())rightHandle
{
    // 判断按钮是单个还是爽个
    if ((leftTitel && leftTitel.length > 0) && (rightTitle && rightTitle.length > 0)) {
        _btnCount = 2;
    }else if ((leftTitel && leftTitel.length > 0) && (!rightTitle || rightTitle.length == 0)) {
        _btnCount = 1;
        isLeft = YES;
    }else if ((rightTitle && rightTitle.length > 0) && (!leftTitel || leftTitel.length == 0)) {
        _btnCount = 1;
        isLeft = NO;
    }else {
        _btnCount = 0;
    }

    // 如果handle---block中有值赋值，给按钮触发其中的方法
    if (leftHandle) {
        self.actionleftBlock = leftHandle;
    }
    if (rightHandle) {
        self.actionrightBlock = rightHandle;
    }
    
    
    [self checkBtnWithLeftTitle:leftTitel rightTitle:rightTitle leftTitleColor:leftTitleColor rightTitleColor:rightTitleColor];
    
}
// 通过block运行点击方法
- (void)clickleftBtn
{
    [self removeFromSuperview];
    if (self.actionleftBlock) {
        self.actionleftBlock();
    }
}


- (void)clickrightBtn
{
    [self removeFromSuperview];
    if (self.actionrightBlock) {
        self.actionrightBlock();
    }
}

- (void)checkCenterViewFrameWithMassageHeight:(CGFloat)massageHeight titleHeight:(CGFloat)titleHeight
{
    if (massageHeight > 0 && titleHeight <= 0) {
        self.centerView.height = massageHeight + mLabelPaddingTop * 2 + 1 + BTN_HEIGHT;
    }else if (massageHeight <= 0 && titleHeight > 0) {
        self.centerView.height = titleHeight + mLabelPaddingTop * 2 + 1 + BTN_HEIGHT;
    }else if (massageHeight > 0 && titleHeight > 0) {
        self.centerView.height = massageHeight + titleHeight + mLabelPaddingTop + tLabelPaddingTop + tLabelPaddingBottom + 1 + BTN_HEIGHT;
    }
    self.centerView.centerY = UIWINDOW.center.y;
    
}

- (void)checkBtnWithLeftTitle:(NSString *)leftTitel rightTitle:(NSString *)rightTitle leftTitleColor:(UIColor *)leftTitleColor rightTitleColor:(UIColor *)rightTitleColor
{
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.centerView.height - BTN_HEIGHT, self.centerView.width, 1)];
    lineView.backgroundColor = MARK_Color(221, 221, 223, 1);
    [self.centerView addSubview:lineView];
    
    UIButton *btn1 = nil;
    UIButton *btn2 = nil;
    UIView *lineView2 = nil;
    
    switch (_btnCount) {
        case 0:
            self.defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.defaultBtn setTitle:@"确定" forState:UIControlStateNormal];
            [self.defaultBtn setTitleColor:MARK_Color(0, 160, 233, 1) forState:UIControlStateNormal];
            self.defaultBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            self.defaultBtn.width = self.centerView.width;
            self.defaultBtn.height = 37;
            self.defaultBtn.x = 0;
            self.defaultBtn.y = lineView.y;
            
            [self.defaultBtn addTarget:self action:@selector(clickleftBtn) forControlEvents:UIControlEventTouchUpInside];
            [self.centerView addSubview:self.defaultBtn];
            break;
            
        case 1:
            [self.defaultBtn removeFromSuperview];

            self.defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (isLeft) {
                if (leftTitel && leftTitel.length > 0) {
                    [self.defaultBtn setTitle:leftTitel forState:UIControlStateNormal];
                }else {
                    [self.defaultBtn setTitle:@"确定" forState:UIControlStateNormal];
                }
                if (leftTitleColor) {
                    [self.defaultBtn setTitleColor:leftTitleColor forState:UIControlStateNormal];
                }else {
                    [self.defaultBtn setTitleColor:MARK_Color(0, 160, 233, 1) forState:UIControlStateNormal];
                }
            }else {
                if (rightTitle && rightTitle.length > 0) {
                    [self.defaultBtn setTitle:rightTitle forState:UIControlStateNormal];
                }else {
                    [self.defaultBtn setTitle:@"确定" forState:UIControlStateNormal];
                }
                if (rightTitleColor) {
                    [self.defaultBtn setTitleColor:rightTitleColor forState:UIControlStateNormal];
                }else {
                    [self.defaultBtn setTitleColor:MARK_Color(0, 160, 233, 1) forState:UIControlStateNormal];
                }
            }

            self.defaultBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            self.defaultBtn.width = self.centerView.width;
            self.defaultBtn.height = 37;
            self.defaultBtn.x = 0;
            self.defaultBtn.y = lineView.y;
            
            [self.defaultBtn addTarget:self action:@selector(clickleftBtn) forControlEvents:UIControlEventTouchUpInside];
            [self.centerView addSubview:self.defaultBtn];
            break;
            
        case 2:
            [self.defaultBtn removeFromSuperview];
            
            btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            if (leftTitel && leftTitel.length > 0) {
                [btn1 setTitle:leftTitel forState:UIControlStateNormal];
            }else {
                [btn1 setTitle:@"取消" forState:UIControlStateNormal];
            }
            
            if (leftTitleColor) {
                [btn1 setTitleColor:leftTitleColor forState:UIControlStateNormal];
            }else {
                [btn1 setTitleColor:MARK_Color(0, 160, 233, 1) forState:UIControlStateNormal];
            }
            btn1.titleLabel.font = [UIFont systemFontOfSize:17];
            btn1.width = self.centerView.width / 2;
            btn1.height = 37;
            btn1.x = 0;
            btn1.y = lineView.y;
            
            [btn1 addTarget:self action:@selector(clickleftBtn) forControlEvents:UIControlEventTouchUpInside];
            [self.centerView addSubview:btn1];
            
            lineView2 = [[UIView alloc] initWithFrame:CGRectMake(btn1.width, lineView.y, 1, btn1.height)];
            lineView2.backgroundColor = MARK_Color(221, 221, 223, 1);
            [self.centerView addSubview:lineView2];
            
            btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            if (rightTitle && rightTitle.length > 0) {
                [btn2 setTitle:rightTitle forState:UIControlStateNormal];
            }else {
                [btn2 setTitle:@"确定" forState:UIControlStateNormal];
            }
            
            if (rightTitleColor) {
                [btn2 setTitleColor:rightTitleColor forState:UIControlStateNormal];
            }else {
                [btn2 setTitleColor:MARK_Color(0, 160, 233, 1) forState:UIControlStateNormal];
            }
            btn2.titleLabel.font = [UIFont systemFontOfSize:17];
            btn2.width = self.centerView.width / 2;
            btn2.height = 37;
            btn2.x = btn1.width;
            btn2.y = lineView.y;
            
            [btn2 addTarget:self action:@selector(clickrightBtn) forControlEvents:UIControlEventTouchUpInside];
            [self.centerView addSubview:btn2];
            break;
            
        default:
            break;
    }
    

}

// 类方法
+(void)alertViewWithTitle:(NSString *)title titleColor:(UIColor *)titleColor massage:(NSString *)massage massageColor:(UIColor *)massageColor alertViewBGColor:(UIColor *)BGColor isCornerRadius:(BOOL)isCornerRadius
{
    [[WAlertView shareAlertViewWithW] addAlertViewWithTitle:title titleColor:titleColor massage:massage massageColor:massageColor alertViewBGColor:BGColor isCornerRadius:isCornerRadius];
}

+ (void)alertActionWithLeftTitle:(NSString *)leftTitel rightTitle:(NSString *)rightTitle leftTitleColor:(UIColor *)leftTitleColor rightTitleColor:(UIColor *)rightTitleColor leftHandle:(void (^)())leftHandle rightHandle:(void (^)())rightHandle
{
    [[WAlertView shareAlertViewWithW] addActionWithLeftTitle:leftTitel rightTitle:rightTitle leftTitleColor:leftTitleColor rightTitleColor:rightTitleColor leftHandle:^{
        
        if (leftHandle) {
            leftHandle();
        }
        
    } rightHandle:^{
        
        if (rightHandle) {
            rightHandle();
        }
        
    }];
}

@end
