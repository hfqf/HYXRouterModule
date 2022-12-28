//
//  UIApplication+HYXRouter.h
//  ChinaNationalSports
//
//  Created by Points on 2019/9/16.
//  Copyright © 2019 Points. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (HYXRouter)

+ (NSString *)uiRouterUrl:(Class) _class;

+ (NSString *)serviceRouterUrl:(Class) _class;

@end

NS_ASSUME_NONNULL_END
