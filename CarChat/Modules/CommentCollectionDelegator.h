//
//  CommentCollectionDelegator.h
//  CarChat
//
//  Created by Develop on 15/1/21.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CommentCollectionConfigBlock)(id item, UITableViewCell * cell);
typedef void(^CommentCollectionSelectingBlock)(id item);

@interface CommentCollectionDelegator : NSObject <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)identifier;

@property (nonatomic, copy) CommentCollectionConfigBlock configBLock;
@property (nonatomic, copy) CommentCollectionSelectingBlock selectingBlock;

@end
