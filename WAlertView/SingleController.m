//
//  SingleController.m
//  WAlertView
//
//  Created by 张伟立 on 16/6/18.
//  Copyright © 2016年 com.william. All rights reserved.
//

#import "SingleController.h"
#import "WAlertView.h"
#define MARK_Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface SingleController ()

@end

@implementation SingleController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"ClickMe" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickMe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickMe
{
    [WAlertView alertViewWithTitle:@"我是标题啊我是标题啊我是标题啊我是标题啊" titleColor:MARK_Color(51, 51, 51, 1) massage:@"我是内容内容我是内容内容我是内容内容我是内容内容我是内容内容我是内容内容" massageColor:nil alertViewBGColor:[UIColor whiteColor] isCornerRadius:YES];
    [WAlertView alertActionWithLeftTitle:nil rightTitle:@"right" leftTitleColor:nil rightTitleColor:[UIColor purpleColor] leftHandle:^{
        self.view.backgroundColor = [UIColor yellowColor];
    } rightHandle:nil];
}


@end
