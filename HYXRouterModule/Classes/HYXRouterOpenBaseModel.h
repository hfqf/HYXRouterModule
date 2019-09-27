//
//  HYXRouterOpenBaseModel.h
//  HYXRouterModule
//
//  Created by Points on 2019/9/19.
//  Copyright © 2019 huiyinxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN




#define Router_HidesBottomBar  @"hidesBottomBarWhenPushed"
/*
 *在当前页面需要先返回,再push操作
 */
#define Router_NeedAutoPop     @"isNeedAutoPop"

/*
 *在当前页面只需要返回,不要push操作
 */
#define Router_OnlyAutoPop     @"isOnlyAutoPop"


/*
 *拦截器页面过后的下一个页面
*/
#define Router_targetVcName    @"targetVcName"

/**
 通过路由组件打开组件时传递的参数
 */
@interface HYXRouterOpenBaseModel : NSObject
@property(nonatomic,strong)UINavigationController *navi;
@property(nonatomic,strong)NSString *controller;

@end

@interface HYXRouterControllerModel : HYXRouterOpenBaseModel
@property(nonatomic,assign)BOOL hidesBottomBarWhenPushed;
@property(nonatomic,strong)NSDictionary * objectPropertys;//NSString,id,自定义对象，block
@property(nonatomic,strong)NSDictionary * intPropertys;//NSNumber
@property(nonatomic,strong)NSDictionary * boolPropertys;//NSBool

/**
 生成路由跳转model
 
 @param controller 目的控制器名
 @param navi 导航栏控制器
 @return HYXRouterOpenBaseModel
 */
+ (HYXRouterControllerModel *)from:(NSString * __nullable)controller navi:(UINavigationController * __nullable)navi;

/**
 需要传递参数时的生成路由跳转model
 
 @param controller 目的控制器名
 @param navi 导航栏控制器
 @param objectPropertys 将要传入的NSString,id,自定义对象，block等参数的类名和value
 @param intPropertys 将要传入的NSNumber参数的类名和value
 @param boolPropertys 将要传入的NSBool参数的类名和value
 @return HYXRouterOpenBaseModel
 */
+ (HYXRouterControllerModel *)from:(NSString * __nullable)controller
                            navi:(UINavigationController * __nullable)navi
                 objectPropertys:(NSDictionary * __nullable)objectPropertys
                    intPropertys:(NSDictionary * __nullable)intPropertys
                   boolPropertys:(NSDictionary * __nullable)boolPropertys;
@end

@interface HYXRouterServiceModel : HYXRouterOpenBaseModel

/**
 service组件需要的参数，根据设定service只需几个string类型的值即可,比如一个id，page等。尽可能的简化字段。
 */
@property(nonatomic,strong)NSDictionary * paraPropertys;
@end

NS_ASSUME_NONNULL_END
