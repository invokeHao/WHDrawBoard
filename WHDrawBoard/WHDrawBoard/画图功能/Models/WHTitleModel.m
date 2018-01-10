//
//  WHTitleModel.m
//  WHDrawBoard
//
//  Created by wang on 2017/10/13.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "WHTitleModel.h"

@implementation WHTitleModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.ID = dic[@"id"];
        self.drawName = dic[@"drawName"];
        self.tip = dic[@"tip"];
    }
    return self;
}

@end
