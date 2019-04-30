//
//  QQModel.m
//  LJXXZYS
//
//  Created by a on 2019/4/16.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "QQModel.h"

@implementation QQModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"conclusion" : @"result.data.conclusion",
             @"analysis" : @"result.data.analysis"
             };
}

@end
