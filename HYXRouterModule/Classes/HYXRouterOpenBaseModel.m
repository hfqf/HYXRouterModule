//
//  HYXRouterOpenBaseModel.m
//  HYXRouterModule
//
//  Created by Points on 2019/9/19.
//  Copyright © 2019 huiyinxun. All rights reserved.
//

#import "HYXRouterOpenBaseModel.h"


@implementation HYXRouterOpenBaseModel




@end

@implementation HYXRouterControllerModel

/**
 普通的生成路由跳转model，无需任何参数
 
 @param controller 目的控制器名
 @param navi 导航栏控制器
 @return HYXRouterOpenBaseModel
 */
+ (HYXRouterControllerModel *)from:(NSString * __nullable)controller navi:(UINavigationController * __nullable)navi{
    HYXRouterControllerModel *data = [[HYXRouterControllerModel alloc]init];
    data.navi = navi;
    data.controller = controller;
    data.objectPropertys = @{};
    data.intPropertys = @{};
    data.boolPropertys = @{};
    return data;
}


/**
 需要传递参数时的生成路由跳转model,具体用法请看示例
 
 
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
                   boolPropertys:(NSDictionary * __nullable)boolPropertys{
    HYXRouterControllerModel *data = [[HYXRouterControllerModel alloc]init];
    data.navi = navi;
    data.controller = controller;
    data.objectPropertys = objectPropertys == nil ? @{} : objectPropertys;
    data.intPropertys = intPropertys == nil ? @{} : intPropertys;
    data.boolPropertys = boolPropertys == nil ? @{} : boolPropertys;
    return data;
}



@end
