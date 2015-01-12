//
//  ControllerCoordinator.h
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern const NSInteger RegisterHaveCarButtonTag;
extern const NSInteger RegisterDontHaveCarButtonTag;
extern const NSInteger LoginLoginButtonTag;
extern const NSInteger LoginForgetButtonTag;
extern const NSInteger LoginRegisterButtonTag;
extern const NSInteger ShowLoginFromSomeWhereTag;

@interface ControllerCoordinator : NSObject

+ (void)goNextFrom:(UIViewController *)vc
           whitTag:(NSInteger)tag
        andContext:(void *)context;

@end
