//
//  AcitivitiesTableDelegator.h
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CollectionDelegator.h"
#import "ActivityModel.h"
#import "ActivityCell.h"

@interface ActivitiesCollectionDelegator : CollectionDelegator

@property (nonatomic, assign) ActivityCellStyle style;

@end
