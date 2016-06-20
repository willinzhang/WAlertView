# WAlertView

WAlertView 是自定义AlertView

文字颜色优于系统自带alertview

#DEMO

![](https://github.com/willinzhang/WAlertView/blob/master/demo.gif)

#USED
```objc
    //创建
    [WAlertView alertViewWithTitle:@"我是标题啊我是标题啊我是标题啊我是标题啊" titleColor:MARK_Color(51, 51, 51, 1) massage:@"我是内容内容我是内容内容我是内容内容我是内容内容我是内容内容我是内容内容" massageColor:nil alertViewBGColor:[UIColor whiteColor] isCornerRadius:YES];
    //定义按钮属性，此方法不写默认为一个按钮文字为确定
    [WAlertView alertActionWithLeftTitle:nil rightTitle:@"right" leftTitleColor:nil rightTitleColor:[UIColor purpleColor] leftHandle:^{
        self.view.backgroundColor = [UIColor yellowColor];
    } rightHandle:nil];
```
