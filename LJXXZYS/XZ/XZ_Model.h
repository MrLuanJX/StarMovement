//
//  XZ_Model.h
//  LJXXZYS
//
//  Created by a on 2019/4/15.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZ_YearModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZ_Model : NSObject

@property (nonatomic , copy) NSString * name;
@property (nonatomic , copy) NSString * datetime;
@property (nonatomic , copy) NSString * date;
@property (nonatomic , copy) NSString * all;
@property (nonatomic , copy) NSString * color;
@property (nonatomic , copy) NSString * health;
@property (nonatomic , copy) NSString * love;
@property (nonatomic , copy) NSString * money;
@property (nonatomic , copy) NSString * number;
@property (nonatomic , copy) NSString * QFriend;
@property (nonatomic , copy) NSString * summary;
@property (nonatomic , copy) NSString * work;

/* 本周 */
@property (nonatomic , copy) NSString * weekth;
@property (nonatomic , copy) NSString * job;

/* 月份 */
@property (nonatomic , copy) NSString * month;


@end

NS_ASSUME_NONNULL_END
