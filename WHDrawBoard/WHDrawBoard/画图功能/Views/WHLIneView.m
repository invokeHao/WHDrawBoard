//
//  WHLIneView.m
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "WHLIneView.h"

@implementation WHLIneView
{
    CGFloat _width;
}
-(instancetype)initWithWidth:(CGFloat)width andFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _width = width;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTheLine:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGPoint infoCenter = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

    UIBezierPath* arc1 = [UIBezierPath bezierPathWithArcCenter:infoCenter
                                                        radius:_width
                                                    startAngle:0
                                                      endAngle:2*M_PI
                                                     clockwise:YES];
    UIColor * arcColor = _isSelected ? WHRGBColor(53, 53, 53)  : WHRGBColor(153, 153, 153);
    [arcColor setFill];
    [arc1 fill];
}

-(void)pressTheLine:(UITapGestureRecognizer*)tap{
    self.isSelected = YES;
    [self.delegate selectTheWidth:_width andSelectView:self];
    [self setNeedsDisplay];
}

-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    [self setNeedsDisplay];
}
@end
