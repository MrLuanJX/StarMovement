//
//  Gradient.m
//  LJXXZYS
//
//  Created by a on 2019/4/16.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

UIEdgeInsets safeAreaInsets(void) {
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        safeAreaInsets = [[[[UIApplication sharedApplication] delegate]window]safeAreaInsets];
    }
    return safeAreaInsets;
}

#import "Gradient.h"

@interface Gradient ()

@end

@implementation Gradient

+ (void) getGradientWithFirstColor:(UIColor *)firstColor SecondColor:(UIColor *)secondColor WithView:(UIView *)view {
    CAGradientLayer * gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = @[(id)firstColor.CGColor,(id)secondColor.CGColor];
    gradient.startPoint = CGPointMake(0, 1);
    gradient.endPoint = CGPointMake(1, 0);
    [view.layer addSublayer:gradient];
}

@end
