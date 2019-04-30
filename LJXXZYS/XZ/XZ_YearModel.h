//
//  XZ_MIMAModel.h
//  LJXXZYS
//
//  Created by a on 2019/4/15.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZ_YearModel : NSObject

/* 年*/
@property (nonatomic , copy) NSString * mima;
@property (nonatomic , copy) NSString * luckeyStone;
@property (nonatomic , copy) NSString * date;
@property (nonatomic , copy) NSString * future;
@property (nonatomic , copy) NSString * info;

@property (nonatomic , copy) NSArray * text;
@property (nonatomic , copy) NSArray * health;
@property (nonatomic , copy) NSArray * love;
@property (nonatomic , copy) NSArray * finance;
@property (nonatomic , copy) NSArray * career;

@end

NS_ASSUME_NONNULL_END
