//
//  UsersCollectionDelegator.h
//  CarChat
//
//  Created by Develop on 15/1/20.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "UserCell.h"

typedef void(^UserSelectingBlock)(UserModel *user);
typedef void(^UserCellConfigBlock)(UserModel *user, UserCell * cell);

@interface UsersCollectionDelegator : NSObject <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithUsers:(NSArray *)users cellIdentifier:(NSString *)identifier;

@property (nonatomic, copy) UserCellConfigBlock configBlock;
@property (nonatomic, copy) UserSelectingBlock selectingBlock;

@end
