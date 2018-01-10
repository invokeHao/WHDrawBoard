//
//  WHLIneView.h
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

@class WHLIneView;

@protocol WHLineWithDelegate <NSObject>

@optional

-(void)selectTheWidth:(CGFloat)width andSelectView:(WHLIneView *)LineView;

@end


#import <UIKit/UIKit.h>

@interface WHLIneView : UIView

@property (assign,nonatomic)id<WHLineWithDelegate> delegate;

@property (assign,nonatomic)BOOL isSelected;//选中

-(instancetype)initWithWidth:(CGFloat)width andFrame:(CGRect)frame;


@end
