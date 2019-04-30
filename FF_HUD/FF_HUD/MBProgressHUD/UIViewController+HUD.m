//
//  UIViewController-HUD.m
//  FF_HUD
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "UIViewController+HUD.h"
#define kHUDDelayTimeInterval     2.0

#define kFont(size) [UIFont systemFontOfSize:size]
///色值颜色
#define kHexColor(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define kSCALE(value)  value * [UIScreen mainScreen].bounds.size.width / 750.f

@implementation UIViewController (HUD)

///加载提示...
-(MBProgressHUD *)showLoadingWithText:(NSString *)text {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
-(MBProgressHUD *)showAlertWithText:(NSString *)text {
    MBProgressHUD *hud = [self showAlertWithText:text image:nil completeBlock:nil];
    return hud;
}

///提示显示 - 只有文字
-(MBProgressHUD *)showAlertWithText:(NSString *)text completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock{
    return [self showAlertWithText:text image:nil completeBlock:completeBlock];
}

///提示显示 - 只有图片 (无回调)
-(MBProgressHUD *)showAlertWihtImage:(NSString *)imageName {
    return [self showAlertWithText:nil image:imageName completeBlock:nil];
}

///提示显示 - 只有图片
-(MBProgressHUD *)showAlertWihtImage:(NSString *)imageName completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock{
    return [self showAlertWithText:nil image:imageName completeBlock:completeBlock];
}

///提示显示 - 文字、图片 (无回调)
-(MBProgressHUD *)showAlertWithText:(NSString *)text image:(NSString *)imageName {
    return [self showAlertWithText:text image:imageName completeBlock:nil];
}

-(MBProgressHUD *)showSuccessWithText:(NSString *)text{
    return [self showAlertWithText:text image:@"MBProgress_success" completeBlock:nil];
}

-(MBProgressHUD *)showSuccessWithText:(NSString *)text completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock{
    return [self showAlertWithText:text image:@"MBProgress_success" completeBlock:completeBlock];
}

-(MBProgressHUD *)showFailWithText:(NSString *)text{
    return [self showAlertWithText:text image:@"MBProgress_fail" completeBlock:nil];
}

-(MBProgressHUD *)showFailWithText:(NSString *)text completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock{
    return [self showAlertWithText:text image:@"MBProgress_fail" completeBlock:completeBlock];
}

///提示显示 - 提示完成后回调通知
- (MBProgressHUD *)showAlertWithText:(NSString *)text image:(NSString *)imageName completeBlock:(void (^)(MBProgressHUD * ))completeBlock{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
        //[self hideAllHUDsInView];
        
        if (completeBlock) {
            completeBlock(hud);
        }
        
    });
    
    return hud;
}

- (void)hiddenHUD{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //[self hideAllHUDsInView];
}

- (NSUInteger)hideAllHUDsInView{
    NSArray *huds = [self allHUDsInView];
    for (MBProgressHUD *hud in huds) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES];
    }
    return [huds count];
}

- (NSArray *)allHUDsInView {
    NSMutableArray *huds = [NSMutableArray array];
    NSArray *subviews = self.view.subviews;
    for (UIView *aView in subviews) {
        if ([aView isKindOfClass:[MBProgressHUD class]]) {
            [huds addObject:aView];
        }
    }
    return [NSArray arrayWithArray:huds];
}

@end
