//
//  ViewController.m
//  WAlertView
//
//  Created by 张伟立 on 16/6/17.
//  Copyright © 2016年 com.william. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import "UILabel+UILabel_LabelHeightAndWidth.h"
#import "SingleController.h"
#import "DoubleController.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *backLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)singleBtnAction:(UIButton *)sender {
    [self.navigationController pushViewController:[[SingleController alloc]init] animated:YES];
    

    

}
- (IBAction)doubleBtnAction:(UIButton *)sender {
    [self.navigationController pushViewController:[[DoubleController alloc]init] animated:YES];

}

@end
