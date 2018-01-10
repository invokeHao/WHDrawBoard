//
//  WHTool.m
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "WHTool.h"
#import <MBProgressHUD.h>

@interface WHTool ()

@property (nonatomic,strong) MBProgressHUD *HUD;

@end

@implementation WHTool

+(WHTool *)shareInstance{
    static WHTool * ToolInstance =nil;
    static dispatch_once_t predicate ;
    dispatch_once(&predicate, ^{
        ToolInstance = [[self alloc]init];
    });
    return ToolInstance;
}

-(void)showTextHUD:(UIViewController*)viewController Title:(NSString*)title{
    _HUD=[MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
    
    _HUD.label.textColor =[UIColor whiteColor];
    _HUD.label.font = [UIFont systemFontOfSize:16.0];
    _HUD.label.text = title;
    _HUD.bezelView.backgroundColor = WHRGBColor(242, 242, 242);
    _HUD.mode=MBProgressHUDModeText;
    _HUD.removeFromSuperViewOnHide=YES;
    [_HUD hideAnimated:YES afterDelay:1.6];
}


@end
