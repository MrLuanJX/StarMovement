//
//  ShapeLayerTool.m
//  ainanming
//
//  Created by 盛世智源 on 2018/11/6.
//  Copyright © 2018年 陆义金. All rights reserved.
//

#import "ShapeLayerTool.h"

@implementation ShapeLayerTool

+ (CAShapeLayer *)image:(UIView *)image WitchCorner:(UIRectCorner)corner WithCornerRadii:(CGSize)radSize{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:image.bounds byRoundingCorners:corner cornerRadii:radSize];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = image.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    return maskLayer;
}

+ (void)view:(UIView *)view WitchCorner:(UIRectCorner)corner WithCornerRadii:(CGSize)radSize{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corner cornerRadii:radSize];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = view.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    //    return maskLayer;
}

/// 添加单边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    theView.layer.shadowColor = theColor.CGColor;
    theView.layer.shadowOffset = CGSizeMake(0,0);
    theView.layer.shadowOpacity = 0.1;
    theView.layer.shadowRadius = 1;
    // 单边阴影 顶边
    float shadowPathWidth = theView.layer.shadowRadius;
    CGRect shadowRect = CGRectMake(0, 0-shadowPathWidth/2.0, theView.bounds.size.width, shadowPathWidth);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
    theView.layer.shadowPath = path.CGPath;
}

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

-(void)LJX_AddShadowToView:(UIView *)theView SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(LJXShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth{
    
    theView.layer.masksToBounds = NO;
    theView.layer.shadowColor = shadowColor.CGColor;
    theView.layer.shadowOpacity = shadowOpacity;
    theView.layer.shadowRadius =  shadowRadius;
    theView.layer.shadowOffset = CGSizeZero;
    CGRect shadowRect;
    CGFloat originX = 0;
    CGFloat originY = 0;
    CGFloat originW = theView.bounds.size.width;
    CGFloat originH = theView.bounds.size.height;
    
    switch (shadowPathSide) {
        case LJXShadowPathTop:
            shadowRect  = CGRectMake(originX, originY - shadowPathWidth/2, originW,  shadowPathWidth);
            break;
        case LJXShadowPathBottom:
            shadowRect  = CGRectMake(originX, originH -shadowPathWidth/2, originW, shadowPathWidth);
            break;
            
        case LJXShadowPathLeft:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
            
        case LJXShadowPathRight:
            shadowRect  = CGRectMake(originW - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case LJXShadowPathNoTop:
            shadowRect  = CGRectMake(originX -shadowPathWidth/2, originY +1, originW +shadowPathWidth,originH + shadowPathWidth/2 );
            break;
        case LJXShadowPathAllSide:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY - shadowPathWidth/2, originW +  shadowPathWidth, originH + shadowPathWidth);
            break;
    }
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:shadowRect];
    theView.layer.shadowPath = path.CGPath;
}


-(void)addMaskLayer:(UIView *)view RoundingCorners:(UIRectCorner)roundingCorner CornerRadii:(CGSize)cornerRadii{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:roundingCorner cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = view.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}


@end
