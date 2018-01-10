//
//  WHResultView.h
//  WHDrawBoard
//
//  Created by wang on 2017/10/13.
//  Copyright © 2017年 wang. All rights reserved.
//

typedef enum : NSUInteger {
    FalseType,
    BingoType
} WHResultType;

#import <UIKit/UIKit.h>

typedef void(^saveBlock)();

@interface WHResultView : UIView

@property (strong,nonatomic)saveBlock saveB;

-(void)setSaveB:(saveBlock)saveB;

-(instancetype)initWithFrame:(CGRect)frame andType:(WHResultType)type;


@end
