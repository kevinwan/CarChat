//
//  AcitivitiesTableDelegator.h
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActivityModel.h"
#import "ActivityCell.h"

/**
 *  选中集合空间中某个Item执行的回调Block，由调用者实现
 *
 *  @param activity Item对应的Model对象
 */
typedef void (^ActivitySelectingBlock)(ActivityModel * activity);
/**
 *  配置集合控件中某个Item的方法，由调用者实现，集合控件会
 *
 *  @param activity Item对应的Model对象
 *  @param cell     Item对应的Cell
 */
typedef void (^ActivityCellConfigBlock)(ActivityModel * activity, ActivityCell * cell);

/**
 集合控件（tableview）的委托对象，实现控件所需的委托方法。
 将集合对象的委托逻辑，从Controller中分离管理。
 */
@interface ActivitiesCollectionDelegator : NSObject <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithActivities:(NSArray *)activities cellIdentifier:(NSString *)identifier andCellStyle:(ActivityCellStyle)style;

@property (nonatomic, copy) ActivityCellConfigBlock configBlock;
@property (nonatomic, copy) ActivitySelectingBlock selectingBlock;

@end
