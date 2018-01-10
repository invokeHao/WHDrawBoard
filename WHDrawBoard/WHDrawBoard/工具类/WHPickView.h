//
//  WHPickView.h
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHTitleModel.h"

@protocol WHPickDelegate <NSObject>

@optional

-(void)checkToInputTheDrawName;

@end


typedef void(^WHTabelBlock)(WHTitleModel * model);


@interface WHPickView : UIView

@property (assign,nonatomic)id<WHPickDelegate> delegate;

-(instancetype)initThePickTableWithSouceArr:(NSMutableArray*)sourceArr andSelectBlock:(WHTabelBlock)selectBlock;

@end
