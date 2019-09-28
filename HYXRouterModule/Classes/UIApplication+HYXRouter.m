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
#import "HYXRouter.h"

#define Router_Scheme @"ios"
#define Router_Host   @"huiyinxun.com"

@implementation UIApplication (HYXRouter)

#pragma mark - 使用路由组件注意事项

/**
 *1.方便路由组件的自动注册，说个规则,初始化控制器时：加统一前缀HYX,统一后缀Controller
 */

+ (NSString *)uiRouterUrl:(Class) _class{
    NSString *_url = [NSString stringWithFormat:@"%@://%@/%@",Router_Scheme,Router_Host,NSStringFromClass(_class)];
    return _url;
}

+ (NSString *)serviceRouterUrl:(Class) _class{
    NSString *_url = [NSString stringWithFormat:@"%@://%@/%@",Router_Scheme,Router_Host,NSStringFromClass(_class)];
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
            [MGJRouter registerURLPattern:[self uiRouterUrl:cls]
                          toObjectHandler:^id(NSDictionary *routerParameters) {
                              return [[[cls class] alloc]init];
                          }];
            
            [MGJRouter registerURLPattern:[self uiRouterUrl:cls] toHandler:^(NSDictionary *routerParameters) {
                
                MGJRouterHandler completion = routerParameters[MGJRouterParameterCompletion];
        
                
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
                
                
                if(boolPropertys.allKeys.count > 0){
                    //kvc,NSBool类型传值
                    __block int count = 0;
                    [boolPropertys enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        count++;
                        [vc setValue:obj forKey:key];
                        //某些情况需要先将当前拦截页面pop，再push出新页面,尽量无感知
                        if([key isEqualToString:Router_NeedAutoPop] && [obj boolValue]){
                            [navigationVC popViewControllerAnimated:NO];
                        }
                        
                        //某些情况需要将拦截当前页面直接pop即可 
                        if([key isEqualToString:Router_OnlyAutoPop] && [obj boolValue]){
                            [navigationVC popViewControllerAnimated:NO];
                            completion((id)[HYXRouterSucceed new]);
                            *stop = YES;
                            return;
                        }
                        if(count == boolPropertys.allKeys.count){
                            completion((id)[HYXRouterSucceed new]);
                            [navigationVC pushViewController:vc animated:YES];
                        }
                    }];
                }else{
                    completion((id)[HYXRouterSucceed new]);
                    [navigationVC pushViewController:vc animated:YES];
                }
            }];
        }
    }
    free(classes);
}




@end
