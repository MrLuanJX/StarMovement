//
//  LJXRequestTool.m
//  Text
//
//  Created by 栾金鑫 on 2019/3/31.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "LJXRequestTool.h"
#import "AFNetworking.h"

static AFHTTPSessionManager *_sessionManager;

@implementation LJXRequestTool

+(void)initialize{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    _sessionManager = [AFHTTPSessionManager manager];
    
    AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
    _sessionManager.responseSerializer = response;
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain",@"image/gif", nil];
    
    [_sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
    _sessionManager.requestSerializer.timeoutInterval = 15.0f;
    _sessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
}

+ (instancetype) shareManager {
    static LJXRequestTool * client = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[LJXRequestTool alloc]init];
    });
    return client;
}

+ (void) LJX_requestWithType:(LJXRequestType)type URL:(NSString *)url params:(NSDictionary *)params successBlock:(LJXSuccessBlock)successBlock failureBlock:(LJXFailureBlock)failureBlock{
    
    [self requestWithType:type requestURL:url params:params success:successBlock failure:failureBlock];
}

+ (NSURLSessionTask *) requestWithType:(LJXRequestType)requestType requestURL:(NSString *)requestURL params:(NSDictionary *)params success:(LJXSuccessBlock)success failure:(LJXFailureBlock)failure {
    
    if ([requestURL isEqualToString:@""] || requestURL == nil) {
        return nil;
    }
    requestURL = [requestURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *urlString = [NSURL URLWithString:requestURL] ? requestURL : [self stringUTF8Encoding:requestURL];//检测地址中是否混有中文

    if (requestType == LJX_GET) {
        
       NSURLSessionTask * task = [_sessionManager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            success ? success(responseObject) : nil;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failure ? failure(error) : nil;
        }];
    
        return task;
    } else {
        
         NSURLSessionTask * task = [_sessionManager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            success ? success(responseObject) : nil;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failure ? failure(error) : nil;
        }];

        return task;
    }
}

+ (NSString *)stringUTF8Encoding:(NSString *)urlString {
    /**     如果是9.0之后 使用第一个  */
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0) {
        return [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    }else {
        return [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

@end
