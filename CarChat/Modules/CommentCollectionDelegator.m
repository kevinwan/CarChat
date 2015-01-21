//
//  CommentCollectionDelegator.m
//  CarChat
//
//  Created by Develop on 15/1/21.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "CommentCollectionDelegator.h"

@interface CommentCollectionDelegator ()

@property (nonatomic, strong) NSArray * items;
@property (nonatomic, strong) NSString * identifier;

@end

@implementation CommentCollectionDelegator

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)identifier
{
    if (self = [super init]) {
        self.items = items;
        self.identifier = identifier;
    }
    return self;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.identifier];
    }
    
    self.configBLock([self itemAtIndexPath:indexPath], cell);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectingBlock([self itemAtIndexPath:indexPath]);
}

#pragma mark - Internal Helper
- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[indexPath.row];
}

@end
