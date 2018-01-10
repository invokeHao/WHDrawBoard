//
//  WHLineWidthView.h
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WidthBlock)(CGFloat width);

@interface WHLineWidthView : UIView

@property (copy,nonatomic)WidthBlock block;


-(void)setBlock:(WidthBlock)block;
@end
