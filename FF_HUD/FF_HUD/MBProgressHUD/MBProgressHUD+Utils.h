//
//  MBProgressHUD+Utils.h
//  FF_HUD
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "MBProgressHUD.h"

//NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Utils)

+(MBProgressHUD *)showLoadingWithText:(NSString *)text toView:(UIView *)toView ;

///提示显示 - 只有文字 (无回调)
+(MBProgressHUD *)showAlertWithText:(NSString *)text toView:(UIView *)toView;
///提示显示 - 只有文字 (有回调)
+(MBProgressHUD *)showAlertWithText:(NSString *)text toView:(UIView *)toView completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock;

///提示显示 - 只有图片 (无回调)
+(MBProgressHUD *)showAlertWihtImage:(NSString *)imageName toView:(UIView *)toView;
///提示显示 - 只有图片 (有回调)
+(MBProgressHUD *)showAlertWihtImage:(NSString *)imageName toView:(UIView *)toView completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock;

///提示显示 - 文字、图片 (无回调)
+(MBProgressHUD *)showAlertWithText:(NSString *)text image:(NSString *)imageName toView:(UIView *)toView;

///提示显示通用 - 提示完成后回调通知
+(MBProgressHUD *)showAlertWithText:(NSString *)text image:(NSString *)imageName toView:(UIView *)toView completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock;

///成功 吐丝提示
+(MBProgressHUD *)showSuccessWithText:(NSString *)text toView:(UIView *)toView;
+(MBProgressHUD *)showSuccessWithText:(NSString *)text toView:(UIView *)toView completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock;

///失败 吐丝提示
+(MBProgressHUD *)showFailWithText:(NSString *)text toView:(UIView *)toView;
+(MBProgressHUD *)showFailWithText:(NSString *)text toView:(UIView *)toView completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock;


+(void)hiddenHUDFromShowView:(UIView *)showView;
+ (NSUInteger)hideAllHUDsInView:(UIView *)toView;

@end

//NS_ASSUME_NONNULL_END
