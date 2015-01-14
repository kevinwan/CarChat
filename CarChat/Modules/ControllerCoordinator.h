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
 *  登录结束后使用
 */
extern const NSInteger LoginLoginButtonTag;
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
 *  显示服务条款
 */
extern const NSInteger ShowServerPolicyTag;
/**
 *  建议活动列表，选中某个活动
 */
extern const NSInteger SuggestActivitiesSelectItem;
/**
 *  创建成功活动页面，点击导航栏关闭按钮
 */
extern const NSInteger CreatedActivityCloseButtonItemTag;
/**
 *  创建成功活动页面，点击导航栏邀请按钮
 */
extern const NSInteger CreatedActivityInviteButtonItemTag;
/**
 *  邀请页面，点击导航栏关闭按钮
 */
extern const NSInteger InviteCloseButtonItemTag;
/**
 *  邀请页面，点击导航栏邀请按钮
 */
extern const NSInteger InviteInviteButtonItemTag;
/**
 *  从某个地方显示活动邀请页面
 */
extern const NSInteger ShowInviteDetailFromSomeWhereTag;

@interface ControllerCoordinator : NSObject

/**
 *  切换controller转场
 *
 *  @param vc      当前正在显示的vc
 *  @param tag     以转场触发控件命名，表示当前触发事件，该方法内部定义下一步操作
 *  @param context 转场时传递的上下文参数
 */
+ (void)goNextFrom:(UIViewController *)vc
           whitTag:(NSInteger)tag
        andContext:(id)context;

@end
