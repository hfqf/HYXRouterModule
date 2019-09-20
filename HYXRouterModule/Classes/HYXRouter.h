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
#import "MGJRouter.h"

NS_ASSUME_NONNULL_BEGIN


#define HidesBottomBar  @"hidesBottomBarWhenPushed"

@interface HYXRouter : NSObject


/**
 通过路由组件跳转,调用示例
 
        示例:
             目标控制器的属性
 
             @ protocol  HYXMyTestViewControllerDelegate<NSObject>
 
             @required
 
             - (void)HYXMyTestViewControllerFun1:(NSString *_Nonnull)ret;
 
 
             @end
 
             typedef void(^HYXMyTestViewControllerBlock)(NSDictionary *resp);
 
             @ interface HYXMyTestViewController : HYXBaseCommonController
             @property(nonatomic,copy) NSString *testId;
             @property(nonatomic,weak) id<HYXMyTestViewControllerDelegate>hyxDelegate;
             @property(nonatomic,copy) HYXMyTestViewControllerBlock block;
             @end
 
             具体跳转写法:
             [HYXRouter pushController:[HYXRouterOpenBaseModel
                                  from:@"HYXMyTestViewController"
                                  navi:self.controller.navigationController
                       objectPropertys:@{
                                @"testId":@"3",
                                @"block":block,
                                @"hyxDelegate":self,
                                }
                         intPropertys:@{}
                        boolPropertys:@{
                                    @"hidesBottomBarWhenPushed":@(YES)
                        }]];
 
 

 @param model 参数
 @return BOOL
 */
+ (BOOL)pushController:(HYXRouterOpenBaseModel *)model;




/**
 带拦截器的跳转方法,比如要判断是否已经登录,是否已经分享等

 @param model 原始跳转页面信息
 @param callback 带页面跳转信息的拦截器
 @return BOOL
 */
+ (BOOL)pushController:(HYXRouterOpenBaseModel *)model naviagationCallback:(HYXRouterNavigationCallback *)callback;
@end

NS_ASSUME_NONNULL_END
