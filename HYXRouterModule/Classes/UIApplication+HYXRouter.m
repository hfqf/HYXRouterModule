//
//  UIApplication+HYXRouter.m
//  ChinaNationalSports
//
//  Created by Points on 2019/9/16.
//  Copyright © 2019 huiyinxun. All rights reserved.
//  注册路由

#import "UIApplication+HYXRouter.h"
#import <objc/runtime.h>
#import <MGJRouter/MGJRouter.h>

static const NSString *HYX_ViewController = @"ViewController";

@implementation UIApplication (HYXRouter)

#pragma mark - 使用路由组件注意事项

/**
 *1.方便路由组件的自动注册，说个规则,初始化控制器时：加统一前缀HYX,统一后缀Controller
 */


+ (NSString *)mgRouterUrl:(Class) _class{
    NSString *_url = [NSString stringWithFormat:@"%@://%@",HYX_ViewController,NSStringFromClass(_class)];
    return _url;
}

/**
 遍历app中所有类,根据前缀(HYX)和后缀筛(ViewController)选出自定义的控制器，然后自动注册路由
 */
+(void)load{
    Class *classes;
    unsigned int outCount;
    classes = objc_copyClassList(&outCount);
//    NSMutableDictionary *tmpCache = [NSMutableDictionary dictionary];
    for (unsigned int i = 0; i < outCount; i++) {
        Class cls = classes[i];
        NSString *moduleName = NSStringFromClass(cls);
        if(([moduleName hasPrefix:@"HYX"]&&[moduleName rangeOfString:@"Controller"].length > 0)){
            [MGJRouter registerURLPattern:[self mgRouterUrl:cls]
                          toObjectHandler:^id(NSDictionary *routerParameters) {
                              return [[[cls class] alloc]init];
                          }];
            
            [MGJRouter registerURLPattern:[self mgRouterUrl:cls] toHandler:^(NSDictionary *routerParameters) {
                UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationController"];
                NSString *_class = routerParameters[MGJRouterParameterUserInfo][@"class"];
                
                NSDictionary *objectPropertys = routerParameters[MGJRouterParameterUserInfo][@"objectPropertys"];
                NSDictionary *intPropertys = routerParameters[MGJRouterParameterUserInfo][@"intPropertys"];
                NSDictionary *boolPropertys = routerParameters[MGJRouterParameterUserInfo][@"boolPropertys"];
                
                
                UIViewController *vc = [[NSClassFromString(_class) alloc] init];
                
                //kvc,NSString,id,自定义对象，block类型传值
                [objectPropertys enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    [vc setValue:obj forKey:key];
                }];
                //kvc,NSNumber类型传值
                [intPropertys enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    [vc setValue:obj forKey:key];
                }];
                
                
                //kvc,NSBool类型传值
                [boolPropertys enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        [vc setValue:obj forKey:key];
                }];
                [navigationVC pushViewController:vc animated:YES];
            }];
        }
    }
    free(classes);
}




@end
