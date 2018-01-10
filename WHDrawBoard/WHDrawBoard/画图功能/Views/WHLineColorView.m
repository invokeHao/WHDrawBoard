//
//  WHLineColorView.m
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "WHLineColorView.h"
#import "WHColorView.h"

@interface WHLineColorView ()<WHColorDelegate>

@property (strong,nonatomic) WHColorView * colorView;

@end

@implementation WHLineColorView
{
    UIView * _selectView;
    BOOL isShow;
    WHColorView * checkView;//用于判断当前选中的colorview
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutViews];
    }
    return self;
}

-(void)layoutViews{
    _colorView = [[WHColorView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-60, 40, 40) andColor:[UIColor redColor]];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressToSelectTheColor)];
    [_colorView addGestureRecognizer:tap];
    [self addSubview:_colorView];
    
    _selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 0)];
    _selectView.backgroundColor = [UIColor clearColor];
    _selectView.alpha = 0;
    [self addSubview:_selectView];
    
    NSArray * colorArray = @[[UIColor yellowColor],[UIColor brownColor],[UIColor greenColor],[UIColor blueColor],WHRGBColor(53, 53, 53),[UIColor redColor]];
    for (int i=0; i<6; i++) {
        WHColorView * colorView = [[WHColorView alloc]initWithFrame:CGRectMake(0, 60*i, 40, 40) andColor:colorArray[i]];
        colorView.delegate = self;
        [_selectView addSubview:colorView];
    }
}

-(void)selectTheColor:(UIColor *)color andSelectView:(WHColorView *)colorView{
    _colorView.color = color;//选择颜色按钮
    _block(color);//传值
    //对应的选中的按钮做显示
    if (checkView!=colorView) {
        checkView.isSelected = NO;
        checkView = colorView;
    }
}

-(void)pressToSelectTheColor{
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    spring.springBounciness = 10;//设置弹性系数，数值越大，震动幅度越大
    spring.springSpeed = 5;//设置速度，速度越快，动画效果越快结束
    if (isShow) {
        spring.toValue = [NSValue valueWithCGRect:CGRectMake(0, ViewHeight-60, 40, 0)];
        _selectView.alpha = 0;
    }else{
        spring.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 40, 360)];
        _selectView.alpha = 1;
    }
    [_selectView.layer pop_addAnimation:spring forKey:nil];
    isShow = !isShow;
}


@end
