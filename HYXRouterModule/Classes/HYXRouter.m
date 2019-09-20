//
//  HYXRouter.m
//  ChinaNationalSports
//
//  Created by Points on 2019/9/18.
//  Copyright © 2019 huiyinxun. All rights reserved.
// 路由组件派发中心

#import "HYXRouter.h"
#import <MGJRouter/MGJRouter.h>
@implementation HYXRouter

/**
 通过路由组件跳转,调用示例
 
             示例:
             目标控制器的属性
 
             @protocol  HYXMyTestViewControllerDelegate<NSObject>
 
             @required
 
             - (void)HYXMyTestViewControllerFun1:(NSString *_Nonnull)ret;
 
 
             @end
 
             typedef void(^HYXMyTestViewControllerBlock)(NSDictionary *resp);
 
             @interface HYXMyTestViewController : HYXBaseCommonController
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
                     }
            ]];
 
 @param model 参数
 @return BOOL
 */
+ (BOOL)pushController:(HYXRouterOpenBaseModel *)model{
    
    if(model.navi == nil){
        NSLog(@"push失败,路由导航控制器不能为nil");
        return NO;
    }
    NSString *_url = [UIApplication mgRouterUrl:NSClassFromString(model.controller)];
//    id _vc = [MGJRouter objectForURL:_url];
    [MGJRouter openURL:_url
          withUserInfo:@{@"navigationController":model.navi,
                         @"class":model.controller,
                         @"objectPropertys":model.objectPropertys,
                         @"intPropertys":model.intPropertys,
                         @"boolPropertys":model.boolPropertys,
                         }
            completion:^(id result) {
                
            }];
    
    return YES;
}


/**
 带拦截器的跳转方法,比如要判断是否已经登录,是否已经分享等
 
 @param model 原始跳转页面信息
 @param callback 带页面跳转信息的拦截器
 @return BOOL
 */
+ (BOOL)pushController:(HYXRouterOpenBaseModel *)model naviagationCallback:(HYXRouterNavigationCallback *)callback{
    //拦截策略流程
    if(![self processAllInterceptors:callback]){
        [self pushController:model];
    }
    return YES;
}


/**
 拦截策略，如果一个拦截器都没有，则返回NO，push出原来页面

 @param callback target
 @return BOOL
 */
+(BOOL)processAllInterceptors:(HYXRouterNavigationCallback *)callback{
    
    if([callback isKindOfClass:[HYXRouterLoginInterceptor class]]){
        callback.onFound = ^(HYXRouterNavigationCallback *postcard) {
            
        };
        callback.onLost = ^(HYXRouterNavigationCallback *postcard) {
            
        };
        callback.onArrival = ^(HYXRouterNavigationCallback *postcard) {
            
        };
        callback.onInterrupt = ^(HYXRouterNavigationCallback *postcard) {
            [self pushController:postcard.target];
        };
        if(!callback.isLogined){
            callback.onInterrupt(callback);
            return YES;
        }
    }
    //TODO 其它策略
    return NO;
}
@end

