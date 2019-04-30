//
//  XZ_MIMAModel.m
//  LJXXZYS
//
//  Created by a on 2019/4/15.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "XZ_YearModel.h"

@implementation XZ_YearModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"info" : @"mima.info",
             @"text" : @"mima.text"
             };
}

@end
