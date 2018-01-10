//
//  WHTopFuntionView.h
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^listBlock)();
typedef void(^cleanBlock)();
typedef void(^undoBlock)();
typedef void(^redoBlock)();
typedef void(^doneBlock)();

@interface WHTopFuntionView: UIView

@property (strong,nonatomic) UIButton * cleanBtn;//清屏按钮
@property (strong,nonatomic) UIButton * undoBtn;//撤销按钮
@property (strong,nonatomic) UIButton * redoBtn;//重做按钮
@property (strong,nonatomic) UIButton * doneBtn;//完成按钮

@property (copy,nonatomic) listBlock listB;
@property (copy,nonatomic) cleanBlock cleanB;
@property (copy,nonatomic) undoBlock undoB;
@property (copy,nonatomic) redoBlock redoB;
@property (copy,nonatomic) doneBlock doneB;


-(instancetype)initWithFrame:(CGRect)frame;

-(void)setListB:(listBlock)listB;
-(void)setCleanB:(cleanBlock)cleanB;
-(void)setUndoB:(undoBlock)undoB;
-(void)setRedoB:(redoBlock)redoB;
-(void)setDoneB:(doneBlock)doneB;

@end
