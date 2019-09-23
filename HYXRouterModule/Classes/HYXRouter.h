//
//  HYXRouter.h
//  ChinaNationalSports
//
//  Created by Points on 2019/9/18.
//  Copyright © 2019 huiyinxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIApplication+HYXRouter.h"
#import "HYXRouterLoginInterceptor.h"
#import "HYXRouterNavigationCallback.h"
#import "HYXRouterOpenBaseModel.h"
#import "HYXRouterError.h"
#import "HYXRouterSucceed.h"

#import "MGJRouter.h"



#define HYXROUTER  [HYXRouter shared]

NS_ASSUME_NONNULL_BEGIN


/**
 HYXRouter跳转路由:
 1.根据命名规则自动注册module \
 2.提供UIModule和ServiceModule两个打开方案 \
 3.提供拦截器功能，比如登录 \
 4.使用链式调用,参考js的promise，每次可返回成功或失败的回调信息\
 5.传值时可以携带各种类型参数
 调用示例:\
 
 */
@interface HYXRouter : NSObject
#pragma mark - 调用组件

/**
 调用UIModule
 */
@property(nonatomic,copy)HYXRouter *(^open)(HYXRouterControllerModel *target);

/**
 调用ServiceModule
 */
@property(nonatomic,copy)HYXRouter *(^call)(HYXRouterServiceModel *target);

#pragma mark - 拦截器

/**
 拦截器
 */
@property(nonatomic,copy)HYXRouter *(^interceptor)(HYXRouterNavigationCallback *interceptor);

#pragma mark - Promise

typedef void(^HYXSucceedBlock)(id resp);


/**
 开始执行路由跳转,并可以返回执行结果
 */
@property(nonatomic,copy)HYXRouter *(^then)(HYXSucceedBlock succeed);

typedef void(^HYXErrorBlock)(HYXRouterError * error);


/**
 跳转失败
 */
@property(nonatomic,copy)HYXRouter *(^catchError)(HYXErrorBlock error);

#pragma mark - shared
+ (HYXRouter *)shared;
@end


NS_ASSUME_NONNULL_END
