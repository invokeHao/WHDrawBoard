//
//  WHDrawModel.h
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WHDrawModel : NSObject

@property (assign,nonatomic) CGFloat line_width;

@property (strong,nonatomic) UIColor * line_color;

@property (strong,nonatomic) UIBezierPath * path;

+(instancetype)setupModelWithWidth:(CGFloat)width path:(UIBezierPath*)path andColor:(UIColor*)color;

-(UIImage *)getImageFromView:(UIView *)view;

@end
