//
//  WHLineWidthView.m
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "WHLineWidthView.h"
#import "WHLIneView.h"

@interface WHLineWidthView()<WHLineWithDelegate>

@property (strong,nonatomic)UIButton * checkLineBtn;//选择线宽的btn

@property (strong,nonatomic)UIView * selectLineView;//选择线宽的view

@end

@implementation WHLineWidthView
{
    WHLIneView * checkView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self layoutViews];
    }
    return self;
}

-(void)layoutViews{
    _checkLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_checkLineBtn setFrame:CGRectMake(20, 0, 40, 40)];
    [_checkLineBtn setImage:[UIImage imageNamed:@"icon_pen"] forState:UIControlStateNormal];
    [_checkLineBtn addTarget:self action:@selector(pressToCheckTheLineWidth:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_checkLineBtn];
    
    _selectLineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_checkLineBtn.frame)+5, 5, 0, 0)];
    _selectLineView.alpha = 0;
    [self addSubview:_selectLineView];
    //上面绘制圆
//    for (int i = 0; i<4; i++) {
//        WHLIneView * line = [[WHLIneView alloc]initWithWidth:(i+1)*3 andFrame:CGRectMake(35*i, 0, 30, 30)];
//        [line setBlock:^(CGFloat width) {
//            _block(width);
//        }];
//        [_selectLineView addSubview:line];
//    }
    //考虑到间距不能定制，所以需要单独写
    WHLIneView * line1 = [[WHLIneView alloc]initWithWidth:3 andFrame:CGRectMake(10, 0, 10, 30)];
    line1.delegate =self;
    [_selectLineView addSubview:line1];
    
    WHLIneView * line2 = [[WHLIneView alloc]initWithWidth:6 andFrame:CGRectMake(CGRectGetMaxX(line1.frame)+15, 0, 15, 30)];
    line2.delegate = self;
    [_selectLineView addSubview:line2];
    
    WHLIneView * line3 = [[WHLIneView alloc]initWithWidth:10 andFrame:CGRectMake(CGRectGetMaxX(line2.frame)+15, 0, 20, 30)];
    line3.delegate = self;
    [_selectLineView addSubview:line3];
    
    WHLIneView * line4 = [[WHLIneView alloc]initWithWidth:15 andFrame:CGRectMake(CGRectGetMaxX(line3.frame)+15, 0, 30, 30)];
    line4.delegate = self;
    [_selectLineView addSubview:line4];
}

-(void)selectTheWidth:(CGFloat)width andSelectView:(WHLIneView *)LineView{
    _block(width);
    if (checkView!=LineView) {
        checkView.isSelected = NO;
        checkView = LineView;
    }
}

-(void)pressToCheckTheLineWidth:(UIButton*)button{
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    spring.springBounciness = 10;//设置弹性系数，数值越大，震动幅度越大
    spring.springSpeed = 3;//设置速度，速度越快，动画效果越快结束

    if (button.selected) {
        _selectLineView.alpha = 0;
        spring.toValue = [NSValue valueWithCGRect:CGRectMake(60, 5, 0, 30)];
    }else{
        _selectLineView.alpha = 1.0;
        spring.toValue = [NSValue valueWithCGRect:CGRectMake(65, 5, 200, 30)];
    }
    [_selectLineView.layer pop_addAnimation:spring forKey:nil];
    button.selected = !button.selected;
}


@end
