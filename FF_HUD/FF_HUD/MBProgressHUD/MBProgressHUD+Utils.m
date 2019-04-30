//
//  MBProgressHUD+Utils.m
//  FF_HUD
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "MBProgressHUD+Utils.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define kHUDDelayTimeInterval     2.0

#define kFont(size) [UIFont systemFontOfSize:size]
///色值颜色
#define kHexColor(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define kSCALE(value)  value * [UIScreen mainScreen].bounds.size.width / 750.f

@implementation MBProgressHUD (Utils)

///加载提示...
+(MBProgressHUD *)showLoadingWithText:(NSString *)text toView:(UIView *)toView{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    hud.label.text = text;
    hud.label.font = kFont(kSCALE(28.0));
    //默认是菊花加载 MBProgressHUDModeIndeterminate
    //hud.mode = MBProgressHUDModeText;
    
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = kHexColor(0x333333);
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.margin = kSCALE(50.0);     //距离背景边缘上下左右的间距
    
    return hud;
}

///提示显示 - 只有文字 (无回调)
+(MBProgressHUD *)showAlertWithText:(NSString *)text toView:(UIView *)toView{
    MBProgressHUD *hud = [self showAlertWithText:text image:nil toView:toView completeBlock:nil];
    return hud;
}

///提示显示 - 只有文字
+(MBProgressHUD *)showAlertWithText:(NSString *)text toView:(UIView *)toView completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock{
    return [self showAlertWithText:text image:nil toView:toView completeBlock:completeBlock];
}

///提示显示 - 只有图片 (无回调)
+(MBProgressHUD *)showAlertWihtImage:(NSString *)imageName toView:(UIView *)toView{
    return [self showAlertWithText:nil image:imageName toView:toView completeBlock:nil];
}

///提示显示 - 只有图片
+(MBProgressHUD *)showAlertWihtImage:(NSString *)imageName toView:(UIView *)toView completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock{
    return [self showAlertWithText:nil image:imageName toView:toView completeBlock:completeBlock];
}

///提示显示 - 文字、图片 (无回调)
+(MBProgressHUD *)showAlertWithText:(NSString *)text image:(NSString *)imageName toView:(UIView *)toView{
    return [self showAlertWithText:text image:imageName toView:toView completeBlock:nil];
}

+(MBProgressHUD *)showSuccessWithText:(NSString *)text toView:(UIView *)toView{
    return [self showAlertWithText:text image:@"MBProgress_success" toView:toView completeBlock:nil];
}

+(MBProgressHUD *)showSuccessWithText:(NSString *)text toView:(UIView *)toView completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock{
    return [self showAlertWithText:text image:@"MBProgress_success" toView:toView completeBlock:completeBlock];
}

+(MBProgressHUD *)showFailWithText:(NSString *)text toView:(UIView *)toView{
    return [self showAlertWithText:text image:@"MBProgress_fail" toView:toView completeBlock:nil];
}

+(MBProgressHUD *)showFailWithText:(NSString *)text toView:(UIView *)toView completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock{
    return [self showAlertWithText:text image:@"MBProgress_fail" toView:toView completeBlock:completeBlock];
}

///提示显示 - 提示完成后回调通知
+ (MBProgressHUD *)showAlertWithText:(NSString *)text image:(NSString *)imageName toView:(UIView *)toView completeBlock:(void (^)(MBProgressHUD * ))completeBlock{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    hud.label.text = text;
    hud.label.font = kFont(kSCALE(28.0));
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = kHexColor(0x333333);
    hud.margin = kSCALE(50.0);
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    hud.animationType = MBProgressHUDAnimationZoom;
    
    if (imageName.length > 0) {
        hud.mode = MBProgressHUDModeCustomView;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCALE(80), kSCALE(80))];
        icon.image = [UIImage imageNamed:imageName];
        hud.customView = icon;
        
    }else{
        hud.mode = MBProgressHUDModeText;
    }
    
    //[hud hideAnimated:YES afterDelay:kHUDDelayTimeInterval];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kHUDDelayTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
        
        if (completeBlock) {
            completeBlock(hud);
        }
        
    });
    
    return hud;
}

+ (void)hiddenHUDFromShowView:(UIView *)showView{
    [MBProgressHUD hideHUDForView:showView animated:YES];
    //[MBProgressHUD hideAllHUDsForView:showView animated:YES];
   // [self hideAllHUDsInView:showView];
}

+ (NSUInteger)hideAllHUDsInView:(UIView *)toView{
    NSArray *huds = [self allHUDsInView:toView];
    for (MBProgressHUD *hud in huds) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES];
    }
    return [huds count];
}

+ (NSArray *)allHUDsInView:(UIView *)toView {
    NSMutableArray *huds = [NSMutableArray array];
    NSArray *subviews = toView.subviews;
    for (UIView *aView in subviews) {
        if ([aView isKindOfClass:[MBProgressHUD class]]) {
            [huds addObject:aView];
        }
    }
    return [NSArray arrayWithArray:huds];
}

@end
