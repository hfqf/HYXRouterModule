//
//  HYXRouterLoginInterceptor.m
//  HYXRouterModule
//
//  Created by Points on 2019/9/19.
//  Copyright © 2019 huiyinxun. All rights reserved.
//

#import "HYXRouterLoginInterceptor.h"

@implementation HYXRouterLoginInterceptor
-(instancetype)init{
    if(self = [super init]){
        self.isLogined = YES;
    }
    return self;
}
@end
