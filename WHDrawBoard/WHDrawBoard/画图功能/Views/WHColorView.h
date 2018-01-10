//
//  WHColorView.h
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//
#import <UIKit/UIKit.h>

@class WHColorView;

@protocol WHColorDelegate <NSObject>

@optional

-(void)selectTheColor:(UIColor*)color andSelectView:(WHColorView*)colorView;

@end

@interface WHColorView : UIView


@property (strong,nonatomic)UIColor * color;

@property (assign,nonatomic)id<WHColorDelegate>  delegate;

@property (assign,nonatomic)BOOL isSelected;//被选中


-(instancetype)initWithFrame:(CGRect)frame andColor:(UIColor*)color;

@end
