//
//  ViewController.m
//  FF_HUD
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "ViewController.h"

#import "MBProgressHUD+Utils.h"
#import "UIViewController+HUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self showLoadingWithText:@"loading"];
    
    kShowLoadingHUD
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[self hiddenHUD];
        kHiddenLoadingHUD
    });
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

-(void)showAlert:(UIButton *)sender{
    
//    [MBProgressHUD showAlertWithText:@"success!" toView:self.view completeBlock:^(MBProgressHUD * _Nonnull HUD) {
//        NSLog(@"------- ok -----");
//    }];
    
//    [self showFailWithText:@"预约失败！" completeBlock:^(MBProgressHUD *HUD) {
//        NSLog(@"------- ok -----");
//    }];
    
    
    kSuccessAlert(@"预约失败！");
    
//    kFailAlert(@"预约失败！");
////
//    kTextAlert(@"预约失败！");
    
}

@end
