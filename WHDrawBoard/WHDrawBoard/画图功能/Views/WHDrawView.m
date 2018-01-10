//
//  WHDrawView.m
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "WHDrawView.h"
#import "WHDrawModel.h"

@interface WHDrawView ()

@property (assign,nonatomic)CGMutablePathRef path;

@property (strong,nonatomic)NSMutableArray * pathArray;

@property (strong,nonatomic)NSMutableArray * undoArray;

@property (assign,nonatomic)BOOL isDrawNow;//是否正在绘画

@end


@implementation WHDrawView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _width = 7;
        _color = [UIColor redColor];
        [self layoutViews];
    }
    return self;
}

-(void)layoutViews{
    _tipLabel = [[UILabel alloc]init];
    _tipLabel.font = WHFont(14.0);
    _tipLabel.textColor = WHRGBColor(74, 74, 74);
    [self addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@20);
        make.height.equalTo(@16);
    }];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawView:context];
}

-(void)drawView:(CGContextRef)context{
    for (WHDrawModel * model in _pathArray) {
        CGContextAddPath(context, model.path.CGPath);
        [model.line_color set];
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, model.line_width);
        CGContextDrawPath(context, kCGPathStroke);
    }
    if (_isDrawNow) {
        CGContextAddPath(context, _path);
        [_color set];
        CGContextSetLineWidth(context, _width);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextDrawPath(context, kCGPathStroke);
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    _path = CGPathCreateMutable();
    _isDrawNow = YES;
    CGPathMoveToPoint(_path, nil, touchPoint.x, touchPoint.y);
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    CGPathAddLineToPoint(_path, nil, touchPoint.x, touchPoint.y);
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIBezierPath * path = [UIBezierPath bezierPathWithCGPath:_path];
    WHDrawModel * model = [WHDrawModel setupModelWithWidth:_width path:path andColor:_color];
    [self.pathArray addObject:model];
    CGPathRelease(_path);
    _isDrawNow = NO;
}

//清屏
-(void)clean{
    [_pathArray removeAllObjects];
    [_undoArray removeAllObjects];
    self.tipLabel.text = @"";
    [self setNeedsDisplay];
}
//撤销
-(void)undo{
    if (self.pathArray.count<1) {
        return;
    }
    WHDrawModel * model = [self.pathArray lastObject];
    [self.undoArray addObject:model];
    [self.pathArray removeLastObject];
    [self setNeedsDisplay];
}
//重做
-(void)redo{
    if (self.undoArray.count<1) {
        return;
    }
    WHDrawModel * model = [self.undoArray lastObject];
    [self.pathArray addObject:model];
    [self.undoArray removeLastObject];
    [self setNeedsDisplay];
}

-(NSMutableArray*)pathArray{
    if (!_pathArray) {
        _pathArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _pathArray;
}

-(NSMutableArray *)undoArray{
    if (!_undoArray) {
        _undoArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _undoArray;
}


@end
