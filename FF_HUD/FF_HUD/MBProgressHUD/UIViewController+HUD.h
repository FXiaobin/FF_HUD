//
//  UIViewController-HUD.h
//  FF_HUD
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

#define kSuccessAlert(text)      [self showSuccessWithText:text];
#define kFailAlert(text)         [self showFailWithText:text];
#define kTextAlert(text)         [self showAlertWithText:text];

#define kShowLoadingHUD          [self showLoadingWithText:@"加载中..."];
#define kShowLoading(text)       [self showLoadingWithText:text];
#define kHiddenLoadingHUD        [self hiddenHUD];

//NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HUD)

-(MBProgressHUD *)showLoadingWithText:(NSString *)text;

///提示显示 - 只有文字 (无回调)
-(MBProgressHUD *)showAlertWithText:(NSString *)text;
///提示显示 - 只有文字 (有回调)
-(MBProgressHUD *)showAlertWithText:(NSString *)text completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock;

///提示显示 - 只有图片 (无回调)
-(MBProgressHUD *)showAlertWihtImage:(NSString *)imageName;
///提示显示 - 只有图片 (有回调)
-(MBProgressHUD *)showAlertWihtImage:(NSString *)imageName completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock;

///提示显示 - 文字、图片 (无回调)
-(MBProgressHUD *)showAlertWithText:(NSString *)text image:(NSString *)imageName;

///提示显示通用 - 提示完成后回调通知
-(MBProgressHUD *)showAlertWithText:(NSString *)text image:(NSString *)imageName completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock;

///成功 吐丝提示
-(MBProgressHUD *)showSuccessWithText:(NSString *)text;
-(MBProgressHUD *)showSuccessWithText:(NSString *)text completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock;

///失败 吐丝提示
-(MBProgressHUD *)showFailWithText:(NSString *)text;
-(MBProgressHUD *)showFailWithText:(NSString *)text completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock;


-(void)hiddenHUD;
- (NSUInteger)hideAllHUDsInView;

@end

//NS_ASSUME_NONNULL_END
