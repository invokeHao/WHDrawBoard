//
//  WHTitleModel.h
//  WHDrawBoard
//
//  Created by wang on 2017/10/13.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHTitleModel : NSObject

@property (copy,nonatomic) NSString * ID;

@property (copy,nonatomic) NSString * drawName;

@property (copy,nonatomic) NSString * tip;

-(instancetype)initWithDictionary:(NSDictionary*)dic;

@end
