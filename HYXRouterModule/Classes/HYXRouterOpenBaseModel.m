//
//  HYXRouterOpenBaseModel.m
//  HYXRouterModule
//
//  Created by Points on 2019/9/19.
//  Copyright © 2019 huiyinxun. All rights reserved.
//

#import "HYXRouterOpenBaseModel.h"


@implementation HYXRouterOpenBaseModel

/**
 普通的生成路由跳转model，无需任何参数
 
 @param controller 目的控制器名
 @param navi 导航栏控制器
 @return HYXRouterOpenBaseModel
 */
+ (HYXRouterOpenBaseModel *)from:(NSString *)controller navi:(UINavigationController *)navi{
    HYXRouterOpenBaseModel *data = [[HYXRouterOpenBaseModel alloc]init];
    data.navi = navi;
    data.controller = controller;
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
+ (HYXRouterOpenBaseModel *)from:(NSString * )controller
                            navi:(UINavigationController * )navi
                 objectPropertys:(NSDictionary * )objectPropertys
                    intPropertys:(NSDictionary * )intPropertys
                   boolPropertys:(NSDictionary * )boolPropertys{
    HYXRouterOpenBaseModel *data = [[HYXRouterOpenBaseModel alloc]init];
    data.navi = navi;
    data.controller = controller;
    data.objectPropertys = objectPropertys == nil ? @{} : objectPropertys;
    data.intPropertys = intPropertys == nil ? @{} : intPropertys;
    data.boolPropertys = boolPropertys == nil ? @{} : boolPropertys;
    return data;
}

@end
