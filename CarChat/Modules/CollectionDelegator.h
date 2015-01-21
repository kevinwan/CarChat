//
//  CollectionDelegator.h
//  CarChat
//
//  Created by Develop on 15/1/21.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  配置集合控件中某个Item的方法，由调用者实现，集合控件会
 *
 *  @param activity Item对应的Model对象
 *  @param cell     Item对应的Cell
 */
typedef void(^ConfigBLock)(id item, id cell);

/**
 *  选中集合控件某个Item执行的回调Block，由调用者实现
 *
 *  @param item Item对应的Model对象
 */
typedef void(^SelectingBlock)(id item);

/**
 UITableView的委托和数据源对象，实现tableview必需的委托方法。
 cell为默认高度。
 */
@interface CollectionDelegator : NSObject <UITableViewDelegate, UITableViewDataSource>
- (instancetype)initWithItems:(NSArray *)items andCellIdentifier:(NSString *)cellIdentifier;


@property (nonatomic, readonly) NSArray * items;
@property (nonatomic, readonly) NSString * cellIdentifier;
/**
 *  如果自定义cell，必需设置该属性！！！
 */
@property (nonatomic, weak) Class cellClass;
@property (nonatomic, copy) ConfigBLock configBlock;
@property (nonatomic, copy) SelectingBlock selectingBlock;
@end
