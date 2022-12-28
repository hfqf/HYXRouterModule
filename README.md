
# HYXRouterModule

#### 介绍
```
 1.根据命名规则自动注册module \
 2.提供UIModule和ServiceModule两个打开方案 \
 3.提供拦截器功能，比如登录 \
 4.使用链式调用,参考js的promise，每次可返回成功或失败的回调信息\
 5.传值时可以携带各种类型参数 
```

#### 使用说明

```
    HYXRouterControllerModel *target = [HYXRouterControllerModel
                                        from:@"HYXTest1ViewController"
                                        navi:self.navigationController
                                        objectPropertys:nil
                                        intPropertys:nil
                                        boolPropertys:nil];
    HYXRouterLoginInterceptor *interceptor = [[HYXRouterLoginInterceptor alloc]init];
    interceptor.isLogined =NO;
    interceptor.target    = [HYXRouterControllerModel from:@"HYXTest2ViewController" navi:self.navigationController];
    
    HYXROUTER.open(target)
    .interceptor(interceptor)
    .catchError(^(HYXRouterError * _Nonnull error) {
        
    })
    .then(^(id  _Nonnull resp) {
        
    });
```

