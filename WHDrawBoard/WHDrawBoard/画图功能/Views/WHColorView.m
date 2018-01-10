//
//  WHColorView.m
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "WHColorView.h"

@implementation WHColorView

-(instancetype)initWithFrame:(CGRect)frame andColor:(UIColor *)color{
    self = [super initWithFrame:frame];
    if (self) {
        _color = color;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTheColor:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGPoint infoCenter = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    UIBezierPath* arc1 = [UIBezierPath bezierPathWithArcCenter:infoCenter
                                                        radius:17
                                                    startAngle:0
                                                      endAngle:2*M_PI
                                                     clockwise:YES];
    [_color setFill];
    [arc1 fill];
    
    UIColor * arc2Color = !_isSelected ? WHRGBColor(227, 227, 227) : WHRGBColor(53, 53, 53);
    
    UIBezierPath * arc2 = [UIBezierPath bezierPathWithArcCenter:infoCenter radius:19 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [arc2Color setStroke];
    [arc2 setLineWidth:2];
    [arc2 stroke];
}


-(void)pressTheColor:(UITapGestureRecognizer*)tap{
    self.isSelected = YES;
    [self.delegate selectTheColor:_color andSelectView:self];
    [self setNeedsDisplay];
}

-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    [self setNeedsDisplay];
}

-(void)setColor:(UIColor *)color{
    _color = color;
    [self setNeedsDisplay];
}


@end
