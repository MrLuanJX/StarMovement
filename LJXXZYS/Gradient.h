//
//  Gradient.h
//  LJXXZYS
//
//  Created by a on 2019/4/16.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Gradient : NSObject

+ (void) getGradientWithFirstColor:(UIColor *)firstColor SecondColor:(UIColor *)secondColor WithView:(UIView *)view;

UIEdgeInsets safeAreaInsets(void);

@end

NS_ASSUME_NONNULL_END
