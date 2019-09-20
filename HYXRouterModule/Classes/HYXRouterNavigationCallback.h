//
//  HYXRouterNavigationCallback.h
//  HYXRouterModule
//
//  Created by Points on 2019/9/19.
//  Copyright © 2019 huiyinxun. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "HYXRouterOpenBaseModel.h"
@class HYXRouterNavigationCallback;
/**
 Callback when find the destination.
 
 @param postcard meta
 */
typedef void(^HYXRouterNavigationCallbackOnFound)(HYXRouterNavigationCallback * postcard);

/**
 Callback after lose your way.
 
 @param postcard meta
 */
typedef void(^HYXRouterNavigationCallbackOnLost)(HYXRouterNavigationCallback * postcard);


/**
 Callback after navigation.
 
 @param postcard meta
 */
typedef void(^HYXRouterNavigationCallbackOnArrival)(HYXRouterNavigationCallback * postcard);


/**
 Callback on interrupt.
 
 @param postcard meta
 */
typedef void(^HYXRouterNavigationCallbackOnInterrupt)(HYXRouterNavigationCallback * postcard);



NS_ASSUME_NONNULL_BEGIN

@interface HYXRouterNavigationCallback : NSObject
@property(nonatomic,assign)BOOL         isLogined;
@property(nonatomic,strong)HYXRouterOpenBaseModel         *target;//将要跳转的组件信息
@property(nonatomic,copy)HYXRouterNavigationCallbackOnFound         onFound;
@property(nonatomic,copy)HYXRouterNavigationCallbackOnFound         onLost;
@property(nonatomic,copy)HYXRouterNavigationCallbackOnArrival       onArrival;
@property(nonatomic,copy)HYXRouterNavigationCallbackOnInterrupt     onInterrupt;
@end

NS_ASSUME_NONNULL_END
