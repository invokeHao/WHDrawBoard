//
//  WHDrawView.h
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHDrawView : UIView

@property (strong,nonatomic)UILabel * tipLabel;//提示label

@property (strong,nonatomic) UIColor * color;
@property (assign,nonatomic) CGFloat width;

-(void)clean;

-(void)undo;

-(void)redo;

@end
