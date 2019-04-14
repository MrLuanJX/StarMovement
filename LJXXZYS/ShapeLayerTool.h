//
//  ShapeLayerTool.h
//  ainanming
//
//  Created by 盛世智源 on 2018/11/6.
//  Copyright © 2018年 陆义金. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum :NSInteger{
    LJXShadowPathLeft,
    LJXShadowPathRight,
    LJXShadowPathTop,
    LJXShadowPathBottom,
    LJXShadowPathNoTop,
    LJXShadowPathAllSide
} LJXShadowPathSide;

@interface ShapeLayerTool : NSObject

+ (CAShapeLayer *)image:(UIView *)image WitchCorner:(UIRectCorner)corner WithCornerRadii:(CGSize)radSize;

+ (void)view:(UIView *)view WitchCorner:(UIRectCorner)corner WithCornerRadii:(CGSize)radSize;

- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor;

/*
 * shadowColor 阴影颜色
 *
 * shadowOpacity 阴影透明度，默认0
 *
 * shadowRadius  阴影半径，默认3
 *
 * shadowPathSide 设置哪一侧的阴影，
 
 * shadowPathWidth 阴影的宽度，
 
 */

-(void)LJX_AddShadowToView:(UIView *)theView SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(LJXShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth;

@end

NS_ASSUME_NONNULL_END
