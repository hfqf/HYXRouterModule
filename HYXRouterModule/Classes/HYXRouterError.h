//
//  HYXError.h
//  HYXRouterModule
//
//  Created by Points on 2019/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    error_no_nagation, //无导航栏控制器
    error_no_controller, //无目标控制器
    error_other,//未知错误
} HYXRouterErrorEnum;

@interface HYXRouterError : NSObject
@property(nonatomic,copy)   NSString *desc;
@property(nonatomic,copy)   NSString *req;
@property(nonatomic,assign) HYXRouterErrorEnum errorCode ;

@end

NS_ASSUME_NONNULL_END
