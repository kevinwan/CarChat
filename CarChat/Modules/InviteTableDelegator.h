//
//  InviteTableDelegator.h
//  CarChat
//
//  Created by 赵佳 on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^InviteItemSelectionBlock)(id item);

typedef void(^InviteItemConfigBlock)(id item, UITableViewCell * cell);

@interface InviteTableDelegator : NSObject

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)identifier;

@property (nonatomic, copy) InviteItemConfigBlock configBlock;
@property (nonatomic, copy) InviteItemSelectionBlock selectingBlock;

@end
