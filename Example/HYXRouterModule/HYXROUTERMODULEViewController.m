//
//  HYXROUTERMODULEViewController.m
//  HYXRouterModule
//
//  Created by Points on 09/20/2019.
//  Copyright (c) 2019 Points. All rights reserved.
//

#import "HYXROUTERMODULEViewController.h"
#import <HYXRouter.h>
@interface HYXROUTERMODULEViewController ()

@end

@implementation HYXROUTERMODULEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
