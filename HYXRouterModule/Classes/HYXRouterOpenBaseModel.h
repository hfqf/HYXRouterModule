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

/**
 通过路由组件打开组件时传递的参数
 */
@interface HYXRouterOpenBaseModel : NSObject
@property(nonatomic,strong)UINavigationController *navi;
@property(nonatomic,strong)NSString *controller;
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
+ (HYXRouterOpenBaseModel *)from:(NSString *)controller navi:(UINavigationController *)navi;

/**
 需要传递参数时的生成路由跳转model
 
 @param controller 目的控制器名
 @param navi 导航栏控制器
 @param objectPropertys 将要传入的NSString,id,自定义对象，block等参数的类名和value
 @param intPropertys 将要传入的NSNumber参数的类名和value
 @param boolPropertys 将要传入的NSBool参数的类名和value
 @return HYXRouterOpenBaseModel
 */
+ (HYXRouterOpenBaseModel *)from:(NSString * )controller
                            navi:(UINavigationController * )navi
                 objectPropertys:(NSDictionary * )objectPropertys
                    intPropertys:(NSDictionary * )intPropertys
                   boolPropertys:(NSDictionary * )boolPropertys;
@end


NS_ASSUME_NONNULL_END
