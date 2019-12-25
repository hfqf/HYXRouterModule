//
//  HYXRouter.m
//  ChinaNationalSports
//
//  Created by Points on 2019/9/18.
//  Copyright © 2019 huiyinxun. All rights reserved.
// 路由组件派发中心

#import "HYXRouter.h"
@interface HYXRouter()
@property(nonatomic,strong)HYXRouterOpenBaseModel *targetModel;

@property(nonatomic,strong)HYXRouterNavigationCallback *interceptorModel;

@property(nonatomic,copy)HYXRouterErrorBlock      errorBlock;
@property(nonatomic,copy)HYXRouterSucceedBlock    succeedBlock;
@end

@implementation HYXRouter

+ (HYXRouter *)shared{
    static HYXRouter *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared; 
}
- (instancetype)init{
    if(self=[super init]){
        
    }
    return self;
}

#pragma mark - UI组件
/**
 通过路由组件跳转,调用示例

 @param model 参数
 @return BOOL
 */
- (BOOL)openModule:(HYXRouterControllerModel *)model{
    WeakSelf(weakSelf);
    if([self checkAllConditions:model]){
        NSString *_url = [UIApplication uiRouterUrl:NSClassFromString(model.controller)];
        //    id _vc = [MGJRouter objectForURL:_url];
        [MGJRouter openURL:_url
              withUserInfo:@{@"navigationController":model.navi,
                             @"class":model.controller,
                             @"objectPropertys":model.objectPropertys,
                             @"intPropertys":model.intPropertys,
                             @"boolPropertys":model.boolPropertys,
                             }
                completion:^(id result) {
                    if(weakSelf.succeedBlock){
                        weakSelf.succeedBlock(result);
                    }
                    [weakSelf clear];
                }];
    }else{
         [weakSelf clear];
    }
    return YES;
}

- (void)clear{
    self.targetModel = nil;
    self.interceptorModel = nil;
}

- (BOOL)checkAllConditions:(HYXRouterOpenBaseModel *)model{
    WeakSelf(weakSelf);
    if(model.navi == nil){
        HYXRouterError *error = [[HYXRouterError alloc]init];
        error.errorCode = error_no_nagation;
        if(weakSelf.errorBlock){
            weakSelf.errorBlock(error);
            NSLog(@"push失败,路由导航控制器不能为nil");
        }
        return NO;
    }else if (model.controller == nil){
        HYXRouterError *error = [[HYXRouterError alloc]init];
        error.errorCode = error_no_controller;
        if(weakSelf.errorBlock){
            weakSelf.errorBlock(error);
            NSLog(@"push失败,无目标控制器");
        }
        return NO;
    }
    return YES;
}

/**
 带拦截器的跳转方法,比如要判断是否已经登录,是否已经分享等
 
 @param model 原始跳转页面信息
 @param callback 带页面跳转信息的拦截器
 @return BOOL
 */
- (BOOL)callUIModule:(id)model naviagationCallback:(HYXRouterNavigationCallback *)callback{
    WeakSelf(weakSelf);
    if([weakSelf checkAllConditions:model]){
        //拦截策略流程
        if(![weakSelf processAllInterceptors:callback]){
            [weakSelf openModule:model];
        }
    }else{
        [weakSelf clear];
    }
    return YES;
}

/**
 拦截策略，如果一个拦截器都没有，则返回NO，push出原来页面

 @param callback target
 @return BOOL
 */
- (BOOL)processAllInterceptors:(HYXRouterNavigationCallback *)callback{
    WeakSelf(weakSelf);
    if([callback isKindOfClass:[HYXRouterLoginInterceptor class]]){
        callback.onFound = ^(HYXRouterNavigationCallback *postcard) {
            
        };
        callback.onLost = ^(HYXRouterNavigationCallback *postcard) {
            
        };
        callback.onArrival = ^(HYXRouterNavigationCallback *postcard) {
            
        };
        callback.onInterrupt = ^(HYXRouterNavigationCallback *postcard) {
             [weakSelf openModule:postcard.target];
        };
        if(!callback.isLogined){
            NSLog(@"processAllInterceptors");
            callback.onInterrupt(callback);
            return YES;
        }
    }
    //TODO 其它策略
    return NO;
}

#pragma mark - 服务组件
- (BOOL)callServiceModule:(HYXRouterServiceModel *)model naviagationCallback:(HYXRouterNavigationCallback *)callback{
    return YES;
}

#pragma mark - blocks
- (HYXRouter * _Nonnull (^)(HYXRouterControllerModel * _Nonnull))open{
    WeakSelf(weakSelf);
    return ^(HYXRouterControllerModel *target){
        weakSelf.targetModel = target;
        return weakSelf;
    };
}

- (HYXRouter * _Nonnull (^)(HYXRouterServiceModel * _Nonnull))call{
    WeakSelf(weakSelf);
    return ^(HYXRouterServiceModel *target){
        weakSelf.targetModel = target;
        return weakSelf;
    };
}

- (HYXRouter * _Nonnull (^)(HYXRouterNavigationCallback * _Nonnull))interceptor{
     WeakSelf(weakSelf);
    return ^(HYXRouterNavigationCallback *interceptor){
        weakSelf.interceptorModel = interceptor;
        return weakSelf;
    };
}

- (HYXRouter * _Nonnull (^)(HYXRouterSucceedBlock  _Nonnull))then{
    WeakSelf(weakSelf);
    return ^(HYXRouterSucceedBlock resp){
        weakSelf.succeedBlock =  resp;
        [weakSelf callUIModule:weakSelf.targetModel naviagationCallback:weakSelf.interceptorModel];
        return weakSelf;
    };
}

- (HYXRouter * _Nonnull (^)(HYXRouterErrorBlock _Nonnull))catchError{
    WeakSelf(weakSelf);
    return ^(HYXRouterErrorBlock  error){
        weakSelf.errorBlock = error;
        return weakSelf;
    };
}

@end

