//
//  WHDrawModel.m
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "WHDrawModel.h"

@implementation WHDrawModel

+(instancetype)setupModelWithWidth:(CGFloat)width path:(UIBezierPath *)path andColor:(UIColor *)color{
    WHDrawModel * model = [[WHDrawModel alloc]init];
    model.line_width = width;
    model.line_color = color;
    model.path = path;
    return model;
}



@end
