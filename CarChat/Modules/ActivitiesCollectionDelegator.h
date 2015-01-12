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


typedef void (^ActivitySelectingBlock)(ActivityModel * activity);
typedef void (^ActivityCellConfigBlock)(ActivityModel * activity, UITableViewCell * cell);

@interface ActivitiesCollectionDelegator : NSObject <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithActivities:(NSArray *)activities cellIdentifier:(NSString *)identifier;

@property (nonatomic, copy) ActivityCellConfigBlock configBlock;
@property (nonatomic, copy) ActivitySelectingBlock selectingBlock;

@end
