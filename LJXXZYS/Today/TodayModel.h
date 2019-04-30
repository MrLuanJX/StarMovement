//
//  TodayModel.h
//  LJXXZYS
//
//  Created by a on 2019/4/16.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodayModel : NSObject

@property (nonatomic , copy) NSString * day;

@property (nonatomic , copy) NSString * des;
@property (nonatomic , copy) NSString * ID;
@property (nonatomic , copy) NSString * lunar;
@property (nonatomic , copy) NSString * month;
@property (nonatomic , copy) NSString * pic;
@property (nonatomic , copy) NSString * title;
@property (nonatomic , copy) NSString * year;

@end

NS_ASSUME_NONNULL_END
