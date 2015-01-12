//
//  ControllerCoordinator.h
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  需要登录时使用
 */
extern const NSInteger ShowLoginFromSomeWhereTag;
/**
 *  注册结束后使用
 */
extern const NSInteger RegisterRegisterButtonTag;
/**
 *  点击忘记密码使用
 */
extern const NSInteger LoginForgetButtonTag;
/**
 *  登录页点击注册使用
 */
extern const NSInteger LoginRegisterButtonTag;
/**
 *  登录页忘记密码，重设密码成功调用
 */
extern const NSInteger LoginForgetResetDoneTag;
/**
 *  需要完善个人信息
 */
extern const NSInteger ShowCompleteInfoFromSomeWhereTag;
/**
 *  建议活动列表，选中某个活动
 */
extern const NSInteger SuggestActivitiesSelectItem;

@interface ControllerCoordinator : NSObject

+ (void)goNextFrom:(UIViewController *)vc
           whitTag:(NSInteger)tag
        andContext:(id)context;

@end
