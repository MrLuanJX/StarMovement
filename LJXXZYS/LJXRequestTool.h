//
//  LJXRequestTool.h
//  Text
//
//  Created by 栾金鑫 on 2019/3/31.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    LJX_POST = 0,
    LJX_GET,
} LJXRequestType;

typedef void (^LJXSuccessBlock) (id obj);

typedef void (^LJXFailureBlock) (NSError * error);

@interface LJXRequestTool : NSObject

+ (void) LJX_requestWithType:(LJXRequestType)type URL:(NSString *)url params:(NSDictionary *)params successBlock:(LJXSuccessBlock)successBlock failureBlock:(LJXFailureBlock)failureBlock;

@end
