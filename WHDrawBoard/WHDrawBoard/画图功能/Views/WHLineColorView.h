//
//  WHLineColorView.h
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void(^colorBlock)(UIColor * color);

@interface WHLineColorView : UIView

@property (copy,nonatomic)colorBlock block;

-(void)setBlock:(colorBlock)block;

@end
