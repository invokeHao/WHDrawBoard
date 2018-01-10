//
//  WHResultView.m
//  WHDrawBoard
//
//  Created by wang on 2017/10/13.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "WHResultView.h"

@implementation WHResultView
{
    WHResultType _type;
    UIView * backView;
}
-(instancetype)initWithFrame:(CGRect)frame andType:(WHResultType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _type = type;
        [self layoutViews];
    }
    return self;
}

-(void)layoutViews{
    
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
    backView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressToHiden)];
    [backView addGestureRecognizer:tap];
    [self addSubview:backView];
    
    UIView * centerView = [[UIView alloc]init];
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.layer.cornerRadius = 2;
    centerView.clipsToBounds = YES;
    [backView addSubview:centerView];
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backView);
        make.top.equalTo(@132);
        make.size.mas_equalTo(CGSizeMake(307, 224));
    }];
    //图片view
    UIImageView * showView = [[UIImageView alloc]init];
    [showView setImage:[UIImage imageNamed:@"icon_success"]];
    [centerView addSubview:showView];
    
    UILabel * tipsLabel = [[UILabel alloc]init];
    tipsLabel.font = WHFont(15.0);
    tipsLabel.textColor = WHRGBColor(52, 52, 52);
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [centerView addSubview:tipsLabel];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:WHRGBColor(52, 52, 52) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(pressToCancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn.titleLabel setFont:WHFont(15.0)];
    cancelBtn.layer.cornerRadius = 2;
    cancelBtn.layer.borderColor = WHRGBColor(237, 237, 237).CGColor;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.clipsToBounds = YES;
    [centerView addSubview:cancelBtn];
    
    UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.backgroundColor = WHRGBColor(52, 52, 52);
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(pressToDone) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn.titleLabel setFont:WHFont(15.0)];
    doneBtn.layer.cornerRadius = 2;
    doneBtn.clipsToBounds = YES;
    [centerView addSubview:doneBtn];
    
    [showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.centerX.mas_equalTo(centerView);
        make.size.mas_equalTo(CGSizeMake(205, 88));
    }];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(showView.mas_bottom).with.offset(30);
        make.centerX.mas_equalTo(centerView);
        make.height.equalTo(@16);
    }];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@27);
        make.bottom.equalTo(@-12);
        make.size.mas_equalTo(CGSizeMake(117, 40));
    }];;
    
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-26);
        make.bottom.equalTo(@-12);
        make.size.mas_equalTo(cancelBtn);
    }];
    if (_type==FalseType) {
        //失败的view
        [showView setImage:[UIImage imageNamed:@"icon_fail"]];
        tipsLabel.text = @"啊哦，答错了，再接再厉";
        [doneBtn setTitle:@"再来一次" forState:UIControlStateNormal];
    }else if(_type==BingoType){
        //成功的view
        [showView setImage:[UIImage imageNamed:@"icon_success"]];
        tipsLabel.text = @"恭喜你，答对了";
        [cancelBtn setTitle:@"保存画作" forState:UIControlStateNormal];
        [doneBtn setTitle:@"再来一把" forState:UIControlStateNormal];
    }
}

-(void)pressToCancel{
    if (_type==FalseType) {
        [self pressToHiden];
    }else{
        //保存照片
        _saveB();
    }
}

-(void)pressToDone{
    [self pressToHiden];
}

-(void)pressToHiden{
    [self removeFromSuperview];
}

@end
