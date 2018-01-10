//
//  WHTopFuntionView.m
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "WHTopFuntionView.h"

@implementation WHTopFuntionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self layoutViews];
    }
    return self;
}

-(void)layoutViews{
    //列表按钮
    UIButton * listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [listBtn setFrame:CGRectMake(20, 12, 30, 30)];
    [listBtn setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
    [listBtn addTarget:self action:@selector(pressTheListBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:listBtn];
    
    //清屏按钮
    _cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cleanBtn setFrame:CGRectMake(ViewWidth-200, 12, 30, 30)];
    [_cleanBtn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    [_cleanBtn addTarget:self action:@selector(pressTheCleanBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cleanBtn];
    //撤销按钮
    _undoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_undoBtn setFrame:CGRectMake(CGRectGetMaxX(_cleanBtn.frame)+20, 12, 30, 30)];
    [_undoBtn setImage:[UIImage imageNamed:@"icon_left_press_back"] forState:UIControlStateNormal];
    [_undoBtn addTarget:self action:@selector(pressTheUndoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_undoBtn];
    //重做按钮
    _redoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_redoBtn setFrame:CGRectMake(CGRectGetMaxX(_undoBtn.frame)+20, 12, 30, 30)];
    [_redoBtn setImage:[UIImage imageNamed:@"icon_right_press_back"] forState:UIControlStateNormal];
    [_redoBtn addTarget:self action:@selector(pressTheRedoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_redoBtn];
    //完成按钮
    _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_doneBtn setFrame:CGRectMake(CGRectGetMaxX(_redoBtn.frame)+20, 12, 30, 30)];
    [_doneBtn setImage:[UIImage imageNamed:@"icon_check"] forState:UIControlStateNormal];
    [_doneBtn addTarget:self action:@selector(pressTheDoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_doneBtn];
    
}

#pragma mark- 按钮事件

-(void)pressTheListBtn:(UIButton*)btn{
    _listB();
}

-(void)pressTheCleanBtn:(UIButton*)btn{
    _cleanB();
}

-(void)pressTheUndoBtn:(UIButton*)btn{
    _undoB();
}

-(void)pressTheRedoBtn:(UIButton*)btn{
    _redoB();
}

-(void)pressTheDoneBtn:(UIButton*)btn{
    _doneB();
}



@end
