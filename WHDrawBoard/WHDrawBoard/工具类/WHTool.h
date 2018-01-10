//
//  WHTool.h
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHTool : UIView
+ ( WHTool * _Nonnull )shareInstance;

-(void)showTextHUD:(UIViewController * _Nonnull)viewController Title:(NSString * _Nonnull)title;


@end
